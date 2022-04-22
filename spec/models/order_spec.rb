require 'rails_helper'

RSpec.describe Order, type: :model do
  subject(:order) {
    Order.new(
      email: 'tes@gmail.com',
      status_order: 0,
      total_price: 15000.0
    )
  }

  context 'validation for all field' do
    
    it 'is valid with an email, status_order, and total_price' do
      expect(order).to be_valid
    end

  end

  context 'validation for email field' do

    it 'is invalid without email' do
      order.email = nil
      order.valid?
      expect(order.errors[:email]).to include("can't be blank")
    end 

    it 'is invalid if use wrong format email' do
      order.email = "halo@gigih"
      order.valid?
      expect(order.errors[:email]).to eq order.errors[:email]
    end

  end

end
