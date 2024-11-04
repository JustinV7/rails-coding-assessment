Rails.application.routes.draw do
  apipie
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api do
    resource :weather_forecasts, only: [] do
      post :location
    end
  end
end
