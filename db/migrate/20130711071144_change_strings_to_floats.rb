class ChangeStringsToFloats < ActiveRecord::Migration
  def up
  	connection.execute(%q{
    alter table analytics
    alter column amount
    type float using amount::float
    })
    connection.execute(%q{
    alter table field_list_values
    alter column value
    type float using value::float
    })
    connection.execute(%q{
    alter table field_template_list_values
    alter column value
    type float using value::float
    })
    connection.execute(%q{
    alter table field_templates
    alter column value
    type float using value::float
    })
    connection.execute(%q{
    alter table fields
    alter column value
    type float using value::float
    })
    connection.execute(%q{
    alter table payment_histories
    alter column amount
    type float using amount::float
    })
  end

  def down
  end
end
