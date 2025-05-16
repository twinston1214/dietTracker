class CalorieEntry < ApplicationRecord
    has_one_attached :image
    validates :calories, presence: true, numericality: { greater_than_or_equal_to: 0 }
    validates :meal, presence: true
    validate :meal_must_be_string
    
    private
    
    def meal_must_be_string
        unless meal.match?(/[a-zA-Z]/)
            errors.add(:meal, "must be a string")
        end
    end
end
