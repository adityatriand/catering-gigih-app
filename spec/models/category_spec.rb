require 'rails_helper'

RSpec.describe Category, type: :model do
  context 'validation for all field' do
    
    it 'is valid with a name' do
      
      food = Category.new(
        name: 'Makanan Utama'
      )
  
      expect(food).to be_valid
    end
    
  end
end
