Rails.application.routes.draw do

resources :cart, :collection => { :addMulToCart => :post, :deleteMulFromCart => :post }

  devise_for :users, controllers: { registrations: "registrations/registrations" }
  resources :equipment do
     collection do
      get :addeditdelete
      get :audit
      get :history
      get :report
      get :myitem
      get :search
      get :advance
      post :result
      get :doreserve
      get :item
      get :cancel
      get :approve
      get :return
      post :upload
      post :report
      post :upload_report
      post :doreport
      get :reported_item
      get :reported_detail
      post :checked
      post :unchecked
      post :check_item
      get :notification
      post :qrscanner
      post :qrsubmit
      get :home
      post :home
      get :dashboard
      get :barcode_gen
      get :cart
      get :addToCart
      post :addToCart
      get :deleteFromCart
      get :addMulToCart
      post :addMulToCart
      get :deleteMulFromCart
      post :deleteMulFromCart
      get :action
      post :action
      post :equip_qr_gen
      post :room_qr_gen
      post :addeditdelete
    end
  end
  get 'equipment/addeditdelete'
  post 'equipment/home'
  post 'equipment/room_qr_gen'
  post 'equipment/equip_qr_gen'
  get 'equipment/action'
  post 'equipment/action'
  get 'equipment/deleteMulFromCart'
  post 'equipment/deleteMulFromCart'
  get 'equipment/addMulToCart'
  post 'equipment/addMulToCart'
  post 'equipment/addToCart'
  get 'equipment/deleteFromCart'
  get 'equipment/addToCart'
  get 'equipment/cart'
  get 'equipment/dashboard'
  get 'equipment/home'
  post 'equipment/qrsubmit'
  post 'equipment/qrscanner'
  get 'equipment/notification'
  post 'equipment/check_item'
  post 'equipment/unchecked'
  post 'equipment/checked'
  get 'equipment/reported_detail'
  get 'equipment/reported_item'
  post 'equipment/doreport'
  post 'equipment/upload_report'
  post 'equipment/report'
  post 'equipment/upload'
  get 'equipment/return'
  get 'equipment/cancel'
  get 'equipment/item'
  get 'equipment/advance'
  get 'equipment/myitem'
  get 'equipment/history'
  get 'equipment/audit'
  get 'equipment/report'
  get 'equipment/search'
  get 'equipment/addeditdelete'
  post 'equipment/result'
  get 'equipment/doreserve'
  get 'equipment/approve'
  get 'equipment/barcode_gen'

  root 'equipment#home'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
