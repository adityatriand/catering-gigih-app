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



end
