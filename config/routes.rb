Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations', sessions: 'sessions' }
  get "/training", to: "coach#training_session"
  get "/test", to: "coach#test_session"
  get "/advanced_training", to: "coach#advanced_training_session"
  get "/advanced_test", to: "coach#advanced_test_session"
  post "/results", to: "coach#test_results"
  get "/profile", to: "coach#profile"
end
