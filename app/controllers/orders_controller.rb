class OrdersController < ApplicationController
  before_action :set_order, only: %i[ edit update destroy ]
  before_action :set_item, only: %i[ new edit ]


  # GET /orders or /orders.json
  def index
    if params[:email]
      @orders = Order.show_all_by_email(params[:email])
    else
      @orders = Order.show_all
    end
  end

  # GET /orders/1 or /orders/1.json
  def show
    @order = Order.find_join(params[:id])
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
    @item_orders = Order.get_item_order(params[:id])
    current_items_order_id = OrderDetail.where(order_id: params[:id]).map(&:item_id)
    notyet_items_order_id =[]
    notyet_items_name = []
    notyet_items_price = []

    @items.each do |item|
      if current_items_order_id.include?(item.id) == false
        notyet_items_order_id << item.id
        notyet_items_name << item.name
        notyet_items_price << item.price 
      end
    end

    @notyet_item_orders = notyet_items_order_id.zip(notyet_items_name, notyet_items_price)
  end

  # POST /orders or /orders.json
  def create
    @status_process = false
    @total_price = 0
    email = params[:order][:email]
    @order_items = params[:item]
    if !@order_items.nil?
      @order = Order.create(email: email, status_order: 0)
      @order_items.each do |order_item|
          price_item = Item.select(:price).where(id: order_item).first
          quantity = params["quantity_"+order_item]
          @total_price = @total_price + (price_item[:price] * quantity.to_f)
          new_order_detail = OrderDetail.new(order_id: @order.id, item_id: order_item, price: price_item[:price], quantity: quantity.to_i)
          new_order_detail.save
      end      
      @order.total_price = @total_price
    end
    respond_to do |format|
      if @order_items.nil?
        format.html { redirect_to orders_path, notice: "Unsucessfully process. Order must have 1 item order" }
      elsif @order.save
        format.html { redirect_to order_url(@order), notice: "Order was successfully created." }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1 or /orders/1.json
  def update
    @order.email = params[:order][:email]
    @order.status_order = params[:order][:status_order]
    respond_to do |format|
      if @order.save
        if params[:item] != nil
          item_orders = params[:item]
          item_orders.each do |item|
            quantity = params["quantity_"+item]
            order_detail = OrderDetail.update_item_order(params[:id],item,quantity)
          end
        end
        @order2 = OrderDetail.find_by(order_id: params[:id])
        if @order2.nil?
          order = Order.find_by(id: params[:id])
          order.destroy
          format.html { redirect_to orders_path, notice: "Order was successfully destroyed." }
        else
          format.html { redirect_to order_url(@order), notice: "Order was successfully updated." }
          format.json { render :show, status: :ok, location: @order }
        end
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1 or /orders/1.json
  def destroy
    order_detail = OrderDetail.where(order_id: params[:id])
    order_detail.destroy_all  
    @order.destroy

    respond_to do |format|
      format.html { redirect_to orders_url, notice: "Order was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    def set_item
      @items = Item.all
    end

    # Only allow a list of trusted parameters through.
    def order_params
      params.require(:order).permit(:email, :status_order, :total_price)
    end
end
