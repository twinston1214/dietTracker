class DietTrackerController < ApplicationController
  protect_from_forgery with: :null_session

  # loads all entries for the selected date (or today by default),
  # retrieves the daily goal, and calculates total calories
  #
  def index
    puts "------------------ In Index -----------------------"
    @allCalories = CalorieEntry.all

    puts "# of calories = #{@allCalories.size}"
    @selected_date = params[:date].present? ? Date.parse(params[:date]) : Date.today
    @calories_today = CalorieEntry.where(eaten_on: @selected_date)
    @daily_goal = DailyGoal.find_or_initialize_by(date: @selected_date)
    @daily_goal.goal ||= 2000
    @totalCalories = @calories_today.sum(&:calories)
  end


  # POST /enter_meal
  # Creates a new CalorieEntry for the current date based on submitted form data
  def enterMeal
    puts "---------------- In Enter Meal ----------------------"
    meal = params[:mealInput]
    calories = params[:calorieInput].to_f
    image = params[:imageInput]
    eaten_on = params[:eatenOn].present? ? Date.parse(params[:eatenOn]) : Date.today
    @calorie_entry = CalorieEntry.new(meal: meal, calories: calories, image: image, eaten_on: eaten_on)
  
    respond_to do |format|
      if @calorie_entry.save
        puts "Success!"
        format.html { redirect_to root_path(date: @calorie_entry.eaten_on) }
      else
        format.html { redirect_to root_path(date: @calorie_entry.eaten_on) } 
      end
    end
  end


  # DELETE /calorie_entries/:id
  # Deletes a calorie entry and redirects to the same date view
  def delete
    calorie_entry = CalorieEntry.find(params[:id])
    calorie_entry.destroy
    redirect_to root_path(date: calorie_entry.eaten_on)
  end

  # POST /daily_goal
  # Sets or updates the daily goal for a specific date.
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
