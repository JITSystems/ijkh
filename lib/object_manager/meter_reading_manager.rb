class MeterReadingManager < ObjectManager	
  def self.create(user, params)
    if params[:meter_reading][:field_id]
  	  is_init = true
  	else
  	  is_init = false
  	end

    meter_reading_params = {
    						service_id: 	params[:service_id],
    						reading: 		params[:meter_reading][:reading],
    						field_id: 		params[:meter_reading][:field_id],
    						user_id: 		user.id,
    						is_init: 		is_init
    					   }

    meter_reading = MeterReading.create!(meter_reading_params)

	if params[:snapshot]
      snapshot_url = save_snapshot(user, params[:snapshot], meter_reading.created_at, params[:service_id])
      meter_reading.update_attributes(snapshot_url: snapshot_url)
    end

    unless is_init
      amount = calculate_amount()
    end

  end

	def self.get_by_tariff(tariff)
		tariff.meter_readings
	end

  protected

  def self.calculate_amount(current_value, old_value, field_value)
  	amount = (current_value - old_value)*field_value
  end

  def self.increase_account_amount(account, amount)
  	AccountManager.increase_amount(account, amount)
  end

  def self.save_snapshot(user, snapshot, snapshot_name, service_id)
  	snapshot_name = snapshot_name.to_datetime
	name = snapshot_name.to_s(:number)+'.png'
	directory = File.join('public','images','meter_reading_snapshots', user.id.to_s, service_id.to_s)

	unless File.directory?(directory)
	  FileUtils.mkdir_p(directory)
	end

	path = File.join(directory, name)
	File.open(path, "wb") { |f| f.write(snapshot.read) }
	directory = File.join('images','meter_reading_snapshots', user.id.to_s, service_id.to_s)
	path = File.join(directory, name)
	path
  end

end