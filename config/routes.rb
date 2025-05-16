Rails.application.routes.draw do
  root "diet_tracker#index"
  get "diet_tracker" => "diet_tracker#index"
  get "/" => "diet_tracker#index"
  post "/" => "diet_tracker#enterMeal"
  post "/enter_meal", to: "diet_tracker#enterMeal"
end
