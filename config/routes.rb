Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations', sessions: 'sessions' }
  get "/training", to: "coach#training_session"
  get "/test", to: "coach#test_session"
  post "/results", to: "coach#test_results"
end
