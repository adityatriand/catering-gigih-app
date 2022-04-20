class Item < ApplicationRecord
    validates :name, presence: true, uniqueness: true
    validates :description, presence: true, length: { maximum: 150, too_long: "%{count} characters is the maximum allowed" }
    validates :price, presence: true, numericality: {greater_than_or_equal_to: 0.01}
end
