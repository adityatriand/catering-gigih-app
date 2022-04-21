class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :item
  
  def self.update_item_order(order_id,item_id,quantity)
    if find_by_sql("select * from order_details where order_id=#{order_id} and item_id=#{item_id}").empty?
      price = Item.select(:price).where(id: item_id).first
      create(order_id: order_id, item_id: item_id, price: price[:price], quantity: quantity )
      Order.update_total_price(order_id)
    else
      old_quantity = find_by_sql("select quantity from order_details where order_id=#{order_id} and item_id=#{item_id}").first
      if quantity.to_i == 0
        destory_order_detail(order_id,item_id)
      elsif quantity != old_quantity[:quantity]
        order_detail = find_by_sql("select * from order_details where order_id=#{order_id} and item_id=#{item_id}").first
        order_detail[:quantity] = quantity
        order_detail.save
        Order.update_total_price(order_id)        
      end
    end
  end

  def self.destory_order_detail(order_id,item_id)
    order_detail = find_by_sql("select * from order_details where order_id=#{order_id} and item_id=#{item_id}").first
    order_detail.destroy
  end

end
