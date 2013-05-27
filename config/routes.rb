Spree::Core::Engine.routes.append do

  namespace :admin do
    resource :pickpoint_regions
    resource :pickpoint_main
    resource :pickpoint_settings do
      collection do
        post :dismiss_alert
      end
    end  
    resources :orders do
      resource :pickpoint_delivery
    end
  end
  
  resources :pickpoints, :only => :show, :format => :json
  # Add your extension routes here
end
