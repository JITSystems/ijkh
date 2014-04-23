# encoding: utf-8
class MoveTable
  def vendors
    
  end
  
  def users
    
  end
  
  def places
        def non_utility_vendor(title, phone, work_time, address, non_utility_service_type_id, geocode)
      response = HTTParty.post( "http://izkh.ru/api/1.0/non_utility_vendor?auth_token=#{Auth.get}",
              :body => { :non_utility_vendor => { title: title, phone: phone, work_time: work_time, address: address, non_utility_service_type_id: non_utility_service_type_id },
                     :picture => { url: "http://static-maps.yandex.ru/1.x/?ll=#{geocode}&z=15&l=map&size=300,200&pt=#{geocode}" }}.to_json,
              :headers => {'Content-Type' => 'application/json'})
    end
  end

  def services
    
  end
    
  def service_types
    
  end
end