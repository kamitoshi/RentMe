Rails.application.routes.draw do
  root 'home#top'
  get '/about', to: "home#about", as: "about"
  devise_for :workers, controllers:{
    sessions: "workers/sessions",
    passwords: "workers/passwords",
    registrations: "workers/registrations"
  }
  devise_scope :worker do
    get 'workers/confirm_email', to: 'workers/registrations#confirm_email'
  end
  resources :workers, only:[:index, :show, :edit, :update, :destroy] do
    member do
      get :image_edit
    end
    collection do
      get :delete
    end
  end

  devise_for :employers, controllers:{
    sessions: "employers/sessions",
    passwords: "employers/passwords",
    registrations: "employers/registrations"
  }
  devise_scope :employer do
    get 'employers/confirm_email', to: 'employers/registrations#confirm_email'
  end
  resources :employers, only:[:index, :show, :edit, :update, :destroy] do
    member do
      get :image_edit
    end
    collection do
      get :delete
    end
  end

  resources :suggests
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
