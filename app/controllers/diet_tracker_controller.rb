class DietTrackerController < ApplicationController
  protect_from_forgery with: :null_session
  def index
    puts "------------------ In Index -----------------------"
    @allCalories = CalorieEntry.all
    puts "# of calories = #{@allCalories.size}"
    # @allCalories = @allCalories.sort_by { |calorie_entry| [-calorie_entry.calories, calorie_entry.meal] }

    @totalCalories = @allCalories.sum(&:calories)
  end

  def enterMeal
    puts "---------------- In Enter Meal ----------------------"
    meal = params[:mealInput]
    calories = params[:calorieInput].to_f
    image = params[:imageInput]
    eaten_on = Date.today

    new_entry = CalorieEntry.new(meal: meal, calories: calories, image: image, eaten_on: eaten_on)

    # map = { "meal" => meal, "calories" => calories }
    # new_entry = CalorieEntry.new(map)
    respond_to do |format|
      if new_entry.save
        puts "Success!"
        format.html { redirect_to diet_tracker_url }
      else
        format.html { redirect_to "/" } # can create an error page
      end
    end
  end
end
