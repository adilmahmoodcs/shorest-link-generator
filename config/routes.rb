Rails.application.routes.draw do
  apipie
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace 'api' do
    get '/', to: redirect("/api/#{Api::BaseController::CURRENT_VERSION_PATH}/docs")
    
    namespace 'v1' do
      resources :short_links, only: [:create, :index]
    end
  end
  get "/:id" => "api/v1/short_links#show"


end
