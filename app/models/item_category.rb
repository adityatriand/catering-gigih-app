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
  
end
