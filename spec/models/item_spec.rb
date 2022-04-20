require 'rails_helper'

RSpec.describe Item, type: :model do
  subject(:item) {
    Item.new(
      name: 'Nasi Uduk',
      description: 'Betawi style steamed rice cooked in coconut milk. Delicious!',
      price: 15000.0
    )
  }

  context 'validation for all field' do
    
    it 'is valid with a name, a description, and a price' do
      expect(item).to be_valid
    end

  end

  context 'validation for name field' do
    
    it 'is invalid without a name' do
      item.name = nil
      item.valid?
      expect(item.errors[:name]).to include("can't be blank")
    end

    it "is invalid with a duplicate name" do 
      item1 = Item.create(
        name: "Nasi Uduk",
        description: "Betawi style steamed rice cooked in coconut milk. Delicious!",
        price: 10000.0
      )
      
      item2 = Item.new(
        name: "Nasi Uduk",
        description: "Just with a different description.",
        price: 10000.0
      )
  
      item2.valid?
      
      expect(item2.errors[:name]).to include("has already been taken")
    end
    
  end



end
