class Item < ApplicationRecord
    validates :name, presence: true, uniqueness: true
    validates :description, presence: true, length: { maximum: 150, too_long: "%{count} characters is the maximum allowed" }
end
