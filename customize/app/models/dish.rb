class Dish < ActiveRecord::Base
  attr_accessible :name, :kcal, :yen, :genra, :category, :image_attributes

  has_one :image, class_name: "DishImage", dependent: :destroy
  has_one :stocks, dependent: :destroy
  has_many :customs
  has_many :orders,  through: :customs

  accepts_nested_attributes_for :image

  class << self
    def search(query)
      rel = order("id")
      if query.present?
        rel = rel.where("name LIKE ?", "%#{query}%")
      end
      rel
    end
  end
end
