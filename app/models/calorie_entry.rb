class CalorieEntry < ApplicationRecord
    has_one_attached :image
    validates :calories, presence: true, numericality: { greater_than_or_equal_to: 0 }
    validates :meal, presence: true

    private

end
