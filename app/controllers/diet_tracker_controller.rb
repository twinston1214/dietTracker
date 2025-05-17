class DietTrackerController < ApplicationController
  protect_from_forgery with: :null_session

  # loads all entries for the selected date (or today by default),
  # retrieves the daily goal, and calculates total calories
  #
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


  # POST /enter_meal
  # Creates a new CalorieEntry for the current date based on submitted form data
  def enterMeal
    puts "---------------- In Enter Meal ----------------------"
    @calorie_entry = CalorieEntry.new(calorie_entry_params)
    @calorie_entry.eaten_on ||= Date.today

    # map = { "meal" => meal, "calories" => calories }
    # new_entry = CalorieEntry.new(map)

    if @calorie_entry.save
      redirect_to root_path, notice: "Meal saved sucessfully"
    else
      @selected_date = @calorie_entry.eaten_on || Date.today
      @daily_goal = DailyGoal.find_or_initialize_by(date: @selected_date)
      @calories_today = CalorieEntry.where(eaten_on: @selected_date)
      @totalCalories = @calories_today.sum(:calories)
      render :index
    end
  end

  def calorie_entry_params
    params.require(:calorie_entry).permit(:meal, :calories, :image, :eaten_on)
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
  #
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
