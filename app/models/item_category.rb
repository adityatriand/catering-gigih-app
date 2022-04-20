class ItemCategory < ApplicationRecord
  belongs_to :item
  belongs_to :category

  def self.update_item_category(item_id,category_id)
    if find_by_sql("select * from item_categories where item_id=#{item_id} and category_id=#{category_id}").empty?
      create(item_id: item_id, category_id: category_id)
    else
      destroy_by(item_id: item_id, category_id: category_id)
    end
  end

  def self.get_current_category(item_id)
    find_by_sql("select categories.* from categories inner join item_categories on categories.id = item_categories.category_id where item_categories.item_id = #{item_id} ")
  end

end
