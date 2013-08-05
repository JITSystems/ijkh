class ChangeColumnsToFloatInRecipes < ActiveRecord::Migration
  def up
    connection.execute(%q{
        alter table recipes
        alter column amount
        type float using amount::float
    })
    connection.execute(%q{
        alter table recipes
        alter column total
        type float using total::float
    })
    connection.execute(%q{
        alter table recipes
        alter column po_tax
        type float using po_tax::float
    })
    connection.execute(%q{
        alter table recipes
        alter column service_tax
        type float using service_tax::float
    })
  end

  def down
  end
end
