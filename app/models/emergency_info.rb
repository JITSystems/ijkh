class EmergencyInfo < ActiveRecord::Base
  attr_accessible :description, :emergency_service_id, :phone, :title

  belongs_to :emergency_service
end
