class MeterReadingParams < ParamsManager

	def self.create(params, service, field, user)
		meter_reading_params(params, service, field, user)
	end

private

	def self.meter_reading_params(params, service, field, user)
		m_r_p = {
				 reading:  params[:meter_reading][:reading],
				 service_id: service.id,
				 field_id: field.id,
				 user_id: user.id
				}
		m_r_p.merge!(snapshot_url: params[:meter_reading][:snapshot_url]) if params[:meter_reading][:snapshot_url]

		m_r_p
	end
end