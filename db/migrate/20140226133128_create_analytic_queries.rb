class CreateAnalyticQueries < ActiveRecord::Migration
  def change
    create_table :analytic_queries do |t|
      t.string :title
      t.text :query
    end
  end
end
