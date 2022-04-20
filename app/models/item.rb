class Item < ApplicationRecord
    validates :name, presence: true, uniqueness: true
    validates :description, presence: true, length: { maximum: 150, too_long: "%{count} characters is the maximum allowed" }
    validates :price, presence: true, numericality: {greater_than_or_equal_to: 0.01}

    def self.show_all
        find_by_sql("select items.*, GROUP_CONCAT(categories.name) as category from items left join item_categories on item_id = items.id left join categories on categories.id = category_id group by items.id ")
    end

    def self.find_join(id)
        find_by_sql("select items.*, GROUP_CONCAT(categories.name) as category from items left join item_categories on item_id = items.id left join categories on categories.id = category_id where items.id = #{id} group by items.id ")
    end

end
