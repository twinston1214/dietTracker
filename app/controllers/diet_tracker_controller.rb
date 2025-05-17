class DietTrackerController < ApplicationController
  protect_from_forgery with: :null_session
  def index
    puts "------------------ In Index -----------------------"
    @allCalories = CalorieEntry.all
    
    puts "# of calories = #{@allCalories.size}"
    # @allCalories = @allCalories.sort_by { |calorie_entry| [-calorie_entry.calories, calorie_entry.meal] }
    
    @selected_date = params[:date].present? ? Date.parse(params[:date]) : Date.today
    @calories_today = CalorieEntry.where(eaten_on: @selected_date)
    @daily_goal = DailyGoal.find_or_initialize_by(date: @selected_date)
    @daily_goal.goal ||= 2000
    @totalCalories = @calories_today.sum(&:calories)
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

  def delete
    calorie_entry = CalorieEntry.find(params[:id])
    calorie_entry.destroy
    redirect_to root_path(date: calorie_entry.eaten_on)
  end

  def update_goal
    date = Date.parse(params[:date])
    goal = params[:daily_goal][:goal].to_f
    
    goal_entry = DailyGoal.find_or_initialize_by(date: date)
    goal_entry.goal = goal
    goal_entry.save

    # redirect so user sees updated goal
    redirect_to root_path(date: date)
  end
end
