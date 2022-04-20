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

  context 'validation for description field' do
    
    it 'is invalid without a description' do
      item.description = nil
      item.valid?
      expect(item.errors[:description]).to include("can't be blank")
    end

    it 'is invalid if description more than 150 characrter' do
      item.description = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur ante magna, rutrum in euismod non, porta et elit. Sed ac quam lorem. Duis quis sed Lorem."
      item.valid?
      expect(item.errors[:description]).to include("150 characters is the maximum allowed")
    end
    
  end

  context 'validation for price field' do
    
    it 'is invalid if accept non numeric values for price field' do
      item.price = "10s"
      item.valid?
      expect(item.errors[:price]).to include("is not a number")
    end

    it 'is invalid if price less than 0.01' do
      item.price = 0
      item.valid?
      expect(item.errors[:price]).to include("must be greater than or equal to 0.01")
    end
    
  end


end
