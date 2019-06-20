Rails.application.routes.draw do
  root "homes#index"

  namespace :api, format: :json do
    namespace :v1 do
      mount_devise_token_auth_for "User", at: "auth", controllers: {
        registrations: "api/v1/auth/registrations",
      }
      resources :articles
    end
  end
end
