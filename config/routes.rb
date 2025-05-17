Rails.application.routes.draw do
  root "diet_tracker#index"
  get "diet_tracker" => "diet_tracker#index"
  get "/" => "diet_tracker#index"
  post "/" => "diet_tracker#enterMeal"
  post "/enter_meal", to: "diet_tracker#enterMeal"
  post "/daily_goal", to: "diet_tracker#update_goal", as: :daily_goal
  delete "/calorie_entries/:id", to: "diet_tracker#delete", as: :calorie_entry
end
