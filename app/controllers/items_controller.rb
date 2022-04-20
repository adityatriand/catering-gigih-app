class ItemsController < ApplicationController
  before_action :set_item, only: %i[ show edit update destroy ]
  before_action :set_category, only: %i[ new edit ]

  # GET /items or /items.json
  def index
    @items = Item.show_all
  end

  # GET /items/1 or /items/1.json
  def show
    @item = Item.find_join(params[:id])
  end

  # GET /items/new
  def new
    @item = Item.new
  end

  # GET /items/1/edit
  def edit
    # @id_categories = ItemCategory.where(item_id: params[:id]).map(&:category_id)
  end

  # POST /items or /items.json
  def create
    @item = Item.new(item_params)

    respond_to do |format|
      if @item.save
        categories = params[:category]
        categories.each do |category|
          ItemCategory.create(item_id: @item.id, category_id: category)
        end
        format.html { redirect_to item_url(@item), notice: "Item was successfully created." }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1 or /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        if params[:category] != nil
          categories = params[:category]
          categories.each do |category|
            ItemCategory.update_item_category(params[:id],category)
          end 
        end
        format.html { redirect_to item_url(@item), notice: "Item was successfully updated." }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1 or /items/1.json
  def destroy
    
    item_category = ItemCategory.where(item_id: params[:id])
    item_category.destroy_all

    @item.destroy

    respond_to do |format|
      format.html { redirect_to items_url, notice: "Item was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    def set_category
      @categories = Category.all
    end

    # Only allow a list of trusted parameters through.
    def item_params
      params.require(:item).permit(:name, :description, :price)
    end

end
