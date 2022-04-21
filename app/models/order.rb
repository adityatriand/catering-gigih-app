class Order < ApplicationRecord
    validates :email, presence: true,format: { with: URI::MailTo::EMAIL_REGEXP }

    def self.show_all
        find_by_sql("select orders.id, orders.email, orders.status_order, orders.updated_at, SUM(orders.total_price) as total_price , GROUP_CONCAT(items.name || ' - ' || cast(order_details.quantity as varchar) || ' portion / Rp.' || cast(order_details.price as varchar), ' | '  ) as detail from orders inner join order_details on orders.id = order_details.order_id inner join items on items.id = order_details.item_id group by orders.email ")
    end

    def self.find_join(id)
        find_by_sql("select orders.id, orders.email, orders.status_order, orders.updated_at, SUM(orders.total_price) as total_price , GROUP_CONCAT(items.name || ' - ' || cast(order_details.quantity as varchar) || ' portion / Rp.' || cast(order_details.price as varchar), ' | '  ) as detail from orders inner join order_details on orders.id = order_details.order_id inner join items on items.id = order_details.item_id where orders.id = #{id} group by orders.email ")
    end

end
