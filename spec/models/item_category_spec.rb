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

  context 'validation for all field' do
    
    it 'is valid with item_id and category_id' do
      expect(item_category).to be_valid
    end

  end

end
