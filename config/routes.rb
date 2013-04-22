Ijkh::Application.routes.draw do
  devise_for :users, :controllers => {:sessions => "sessions", :registrations => "registrations"}
  

  root :to => 'predefined_data#index'

# Place  
  get 'api/1.0/places' => 'place#index'
  post 'api/1.0/place' => 'place#create'
  put 'api/1.0/place/:place_id' => 'place#update'

# Service Type
  get 'api/1.0/servicetypes' => 'service_type#index'
  get 'api/1.0/place/:place_id/exservicetypes' => 'service_type#index_non_existant'
  post 'api/1.0/servicetype' => 'service_type#create'

# Service
  get 'api/1.0/place/:place_id/services' => 'service#index'
  post 'api/1.0/place/:place_id/service' => 'service#create'
  post 'api/1.0/place/:place_id/userservice' => 'service#create_user_service'
  put 'api/1.0/userservice/:service_id' => 'service#update_user_service'
  delete 'api/1.0/service/:service_id' => 'service#destroy'

# Tariff  
  get 'api/1.0/service/:service_id/tariff' => 'tariff#index'

# Tariff Template
  get 'api/1.0/servicetype/:service_type_id/tarifftemplates' => 'tariff_template#index'

# Field Template
  get 'api/1.0/fieldtemplate' => 'field_template#index'

# Vendor
  get 'api/1.0/servicetype/:service_type_id/vendors' => 'vendor#index_with_tariffs'

# Meter Reading
  get 'api/1.0/tariff/:tariff_id/meterreadings' => 'meter_reading#index'
  post 'api/1.0/meterreading' => 'meter_reading#create'

# Bill
  get 'api/1.0/unpaid_bills' => 'bill#unpaid_index'
  get 'api/1.0/paid_bills' => 'bill#paid_index'
  get 'api/1.0/bills' => 'bill#index'
  get 'api/1.0/bill/:bill_id/pay' => 'bill#pay_bill'
  get 'api/1.0/detailed_bills' => 'bill#detailed_bill_index'
  put 'api/1.0/bill/:bill_id/switch_status' => 'bill#switch_bill_status' 
  delete 'api/1.0/bill/:bill_id' => 'bill#destroy'

# Freelance Category
  get 'api/1.0/freelancecategory' => 'freelance_category#index'

# Non Utility Service Type
  get 'api/1.0/nonutilityservicetype' => 'non_utility_service_type#index'

# Payment History
  post 'api/1.0/payment_success' => 'payment_history#success'
  post 'api/1.0/payment_fail' => 'payment_history#fail'
end
