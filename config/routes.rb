Rails.application.routes.draw do
  namespace :api, constraints: {format: /json/} do
    namespace :v1 do
      resources :articles, except: %i[new edit]
    end
  end

  mount ActionCable.server => '/cable'
end
