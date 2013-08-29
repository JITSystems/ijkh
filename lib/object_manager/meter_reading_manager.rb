class MeterReadingManager < ObjectManager	
  
  def self.create(user, params)
    # params hash:
    #   service_id
    #   place_id
    #   prev_reading
    #   meter_reading:
    #    id
    #    field_id
    #    reading
    #    snapshot_url

    is_init = params[:prev_reading] ? false : true

    meter_reading_params = {
    						            service_id:   params[:service_id],
    						            reading: 		  params[:meter_reading][:reading],
    						            field_id: 		params[:meter_reading][:field_id],
    						            user_id: 		  user.id,
    						            is_init: 		  is_init
    					             }

    meter_reading = MeterReading.create!(meter_reading_params)

  	if params[:snapshot]
        snapshot_url = save_snapshot(user, params[:snapshot], meter_reading.created_at, params[:service_id])
        meter_reading.update_attribute(:snapshot_url, snapshot_url)
    end

    unless is_init
      account = ServiceManager.get(params[:service_id]).account
      field = FieldManager.get(params[:meter_reading][:field_id])
      amount = calculate_amount(params[:meter_reading][:reading].to_f, params[:prev_reading].to_f, field.value)
      updater = AmountUpdater.new(account)
      updater.set_to(amount)
      account.update_attribute(:status, -1) if account.amount > 0.0
    end
    return meter_reading
  end    

	def self.get_by_tariff(tariff)
		tariff.meter_readings
	end

  def self.get_last(field_id)
    MeterReading.where(field_id: field_id).order("created_at DESC").limit(1).first
  end

  protected

  def self.calculate_amount(current_value, old_value, field_value)
  	amount = (current_value - old_value)*field_value
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