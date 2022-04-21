class Order < ApplicationRecord
    validates :email, presence: true,format: { with: URI::MailTo::EMAIL_REGEXP }

    def self.show_all
        find_by_sql("select orders.* , GROUP_CONCAT(items.name || ' - ' || cast(order_details.quantity as varchar) || ' portion / Rp.' || cast(order_details.price as varchar), ' | '  ) as detail from orders left join order_details on orders.id = order_details.order_id left join items on items.id = order_details.item_id group by orders.email ")
    end

    def self.find_join(id)
        find_by_sql("select orders.* , GROUP_CONCAT(items.name || ' - ' || cast(order_details.quantity as varchar) || ' portion / Rp.' || cast(order_details.price as varchar), ' | '  ) as detail from orders left join order_details on orders.id = order_details.order_id left join items on items.id = order_details.item_id where orders.id = #{id}")
    end

    def self.get_item_order(id)
        find_by_sql("select items.name, items.id, order_details.quantity, order_details.price from order_details inner join orders on orders.id = order_details.order_id inner join items on items.id = order_details.item_id where orders.id = #{id}")
    end

    def self.update_total_price(order_id)
        update_prices = find_by_sql("select SUM(price*quantity) as total_price from order_details where order_id = #{order_id}").first
        order = Order.find_by(id: order_id)
        order.update(total_price: update_prices[:total_price])
    end

end
