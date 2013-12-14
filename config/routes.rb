Expomobile::Application.routes.draw do

  resources :events


  resources :massive_loads

  get "system_configurations/select_event"
  resources :system_configurations

  get "rating/show_rating"

  resources :diaries
  
  get "face_to_faces/generate_diary"
  get "face_to_faces/get_interviewee"
  resources :face_to_faces

  resources :activities

  resources :conferences

  get "qr_generator/generate_qr"
 
  resources :sponsors

  post "workshops/set_tolerance"
  get "visits/visits_to_workshops_index"
  get "visits/visits_to_exhibitors_index"
  get "visits/visits_to_workshops_by_subgroup"
  get "visits/visits_to_workshops_by_workshop"
  get "visits/visits_to_exhibitors_by_subgroup"
  get "visits/visits_to_exhibitors_by_exhibitor"
  get "visits/visits_to_workshops"
  get "visits/visits_to_exhibitors"
  get "visits/visits_to_workshops_generate_report"
  get "visits/visits_to_exhibitors_generate_report"
  get "visits/visits_to_workshops_generate_report_by_workshop"
  get "visits/visits_to_exhibitors_generate_report_by_exhibitor"
  get "visits/control_numbers_report_html"
  get "visits/control_numbers_report_pdf"

  resources :expositions
  
  get "mobile_services/rate"
  get "mobile_services/index_diary_days"
  get "mobile_services/show_diary"
  get "mobile_services/index_diaries"
  get "mobile_services/index_face_to_face_days"
  get "mobile_services/show_face_to_face"
  get "mobile_services/index_face_to_faces"
  get "mobile_services/index_activity_days"
  get "mobile_services/show_activity"
  get "mobile_services/index_activities"
  get "mobile_services/index_conference_days"
  get "mobile_services/show_conference"
  get "mobile_services/index_conferences"
  get "mobile_services/show_sponsor"
  get "mobile_services/index_sponsors"
  get "mobile_services/get_attendee_id"
  get "mobile_services/get_attendee_nip"
  get "mobile_services/index_offerts"
  get "mobile_services/show_offert"
  get "mobile_services/index_exhibitors"
  get "mobile_services/show_exhibitor"  
  get "mobile_services/index_workshop_days"
  get "mobile_services/index_exposition_days"
  get "mobile_services/index_workshops"
  get "mobile_services/index_expositions"
  get "mobile_services/index_expositions_names"
  get "mobile_services/register_visit_to_workshop"
  get "mobile_services/register_visit_to_exposition"
  
  resources :hours

  resources :subgroups
  
  get "schedules/subgroup_change"
  post "schedules/deallocate"
  post "schedules/do_association"
  get "schedules/associate_workshop_group"

  resources :rooms

  resources :workshops

  resources :groups

  resources :offerts

  resources :exhibitors
  
  get "attendees/get_subgroups"
  match "register" => "attendees#register"
  match "register_attendee" => "attendees#register_attendee"
  get "attendees/print_gafete_c"
  get "attendees/print_gafete_b"
  get "attendees/print_gafete_a"
  get "attendees/generate_gafete"
  get "attendees/get_all_attendee_names"
  get "attendees/get_attendee_by_name"
  get "attendees/get_attendee"
  resources :attendees

  get "welcome/index"

  devise_for :users

  resources :users

  devise_scope :user do
    get "devise/sessions/sing_out" => "devise/sessions#destroy", :as => :destroy_user_session
    get "devise/sessions/links" => "devise/sessions#links", :as => :links
    match 'devise/registrations/:id/edit' => 'devise/registrations#edit', :as => :edit_user
    #match 'devise/registrations/new' => 'devise/registrations#new', :as => :new_user
  end

  get "welcome/index"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
