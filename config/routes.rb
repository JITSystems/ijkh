Ijkh::Application.routes.draw do
  devise_for :users, :controllers => {:sessions => "sessions", :registrations => "registrations"}
  

  root :to => 'predefined_data#index'

  get 'api/1.0/predefined_data' => 'predefined_data#index'
  get 'api/1.0/places' => 'place#index'
  get 'api/1.0/servicetypes' => 'service_type#index'
  get 'api/1.0/service/:service_id/tariff' => 'tariff#index'
  get 'api/1.0/place/:place_id/services' => 'service#index'
  get 'api/1.0/servicetype/:service_type_id/tarifftemplates' => 'tariff_template#index'
  get 'api/1.0/servicetype/:service_type_id/vendors' => 'vendor#index_with_tariffs'
  get 'api/1.0/tariff/:tariff_id/meterreadings' => 'meter_reading#index'
  get 'api/1.0/place/:place_id/exservicetypes' => 'service_type#index_non_existant'
  get 'api/1.0/freelancecategory' => 'freelance_category#index'
  get 'api/1.0/fieldtemplate' => 'field_template#index'
  get 'api/1.0/nonutilityservicetype' => 'non_utility_service_type#index'
  get 'api/1.0/unpaid_bills' => 'bill#unpaid_index'
  get 'api/1.0/paid_bills' => 'bill#paid_index'
  get 'api/1.0/bills' => 'bill#index'

  post 'api/1.0/place' => 'place#create'

  post 'api/1.0/place/:place_id/userservice' => 'service#create_user_service'
  post 'api/1.0/place/:place_id/service' => 'service#create'

  post 'api/1.0/servicetype' => 'service_type#create'
  post 'api/1.0/meterreading' => 'meter_reading#create'

  put 'api/1.0/place/:place_id' => 'place#update'
  put 'api/1.0/userservice/:service_id' => 'service#update_user_service'

  delete 'api/1.0/service/:service_id' => 'service#destroy'
end
