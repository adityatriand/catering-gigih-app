require 'rails_helper'

RSpec.describe ItemCategory, type: :model do
  let(:category){
    Category.new(
      name: 'Main Dishes'
    )
  }
  let(:item){
    Item.new(
      name: 'Nasi Uduk',
      description: 'Betawi style steamed rice cooked in coconut milk. Delicious!',
      price: 15000.0
    )
  }
  subject(:item_category){
    ItemCategory.new(
      item: item,
      category: category
    )
  }

  context 'validation for item_id field' do
    
    it 'is invalid without a item_id' do
      item_category.item = nil
      item_category.valid?
      expect(item_category.errors[:item]).to include("must exist")
    end

  end

  context 'validation for catgory_id field' do
    
    it 'is invalid without a category_id' do
      item_category.category = nil
      item_category.valid?
      expect(item_category.errors[:category]).to include("must exist")
    end

  end

end
