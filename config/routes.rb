Rails.application.routes.draw do
  resources :meetings, only: [:show, :create, :destroy]
  resources :tutors
  resources :students
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'

  get 'login/student' => 'sessions#new_student'
  post 'login/student' => 'sessions#create_student'
  get 'login/tutor' => 'sessions#new_tutor'
  post 'login/tutor' => 'sessions#create_tutor'
  delete '/logout' => 'sessions#destroy'
  get 'signup' => 'sessions#signup'

  get 'shop' => 'tutors#choose'
  delete 'shop/:id' => 'tutors#drop'
  post 'shop' => 'tutors#search'
  post 'book/:id' => 'tutors#book'

  get '/questions/:student_id/field/:students_tutor_id' => 'questions#qa'
  delete '/questions/:students_tutor_id/:question_id' => 'questions#delete'
  get 'questions/:students_tutor_id/new' => 'questions#new'
  post 'questions/:students_tutor_id/new' => 'questions#create'

  post 'comments/questions/:question_id/:students_tutor_id/new' => 'comments#create'

  get '/students/:id/tutors/:tutor_id' => 'students#show'
  post '/students/:id/tutors/:tutor_id' => 'meetings#create'

  get '/students/:student_id/tutors/:tutor_id/files' => 'homeworks#index'
  get '/students/:student_id/tutors/:tutor_id/files/new' => 'homeworks#new'
  post '/students/:student_id/tutors/:tutor_id/files/new' => 'homeworks#create'
  delete '/students/:student_id/tutors/:tutor_id/files/:file_id' => 'homeworks#destroy'



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
