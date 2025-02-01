class Product < ApplicationRecord
  validates :title, :description, :image_url, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
  validates :title, uniqueness: true, length: { minimum: 10, message: "length should be atreat 10." }
  validates :image_url, allow_blank: true, format: {
    with: %r{\.(gif|png|jpg)\z}i,
    message: "must be a URL for GIF, JPG, PNG image."
  }
end
