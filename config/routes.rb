Spree::Core::Engine.routes.draw do
  # match 'product_customizations/price', :to => 'product_customizations#price'

  # TODO: match 'customize/:product_id', :to => 'products#customize', :as => 'customize'

  namespace :admin do

    # resources :configuration_exclusions
    resources :product_customization_types do
      resources :customizable_product_options do
        member do
          get :select
          post :select
          get :remove
        end
        collection do
          get :available
          get :selected
        end
      end
    end

    resources :products do
      resources :product_customization_types do
        member do
          get :select
          post :select
          get :remove
        end
        collection do
          get :available
          get :selected
        end
      end
    end #products
  end # namespace :admin

  # TODO: match 'admin/variant_configurations/:variant_id', :to => 'admin/variant_configurations#configure'
end
