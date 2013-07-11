class ChangeReadingToFloatInMeterReadings < ActiveRecord::Migration
  def up
  	connection.execute(%q{
        alter table meter_readings
        alter column reading
        type float using reading::float
    })
  end

  def down
  end
end
