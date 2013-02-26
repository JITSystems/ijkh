class ServiceType < ActiveRecord::Base
	scope :not_included, lambda { |excluded_service_type_ids| { :conditions => ['id NOT IN (?)', excluded_service_type_ids.select(&:service_type_id).join(',')] }}

  attr_accessible :title

  has_many :vendors
  has_many :tariff_templates
end
