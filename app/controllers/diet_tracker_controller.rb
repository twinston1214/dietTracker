class DietTrackerController < ApplicationController
  protect_from_forgery with: :null_session
  def index
    puts "------------------ In Index -----------------------"
    @allCalories = CalorieEntry.all
    puts "# of calories = #{@allCalories.size}"
    @allCalories = @allCalories.sort_by { |calorie_entry| [-calorie_entry.calories, calorie_entry.meal] }
  end

  def enterMeal
    puts "---------------- In Enter Bid ----------------------"
    meal = params[:bidderInput]
    calories = params[:amountInput].to_f
    map = { "meal" => meal, "calories" => calories }
    newRow = CalorieEntry.new(map)
    respond_to do |format|
      if newRow.save
        puts "Success!"
        format.html { redirect_to diet_tracker_url }
      else
        format.html { redirect_to "/" } # can create an error page
      end
    end
  end
end
