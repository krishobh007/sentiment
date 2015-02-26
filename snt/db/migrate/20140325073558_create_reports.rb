class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.string :name
      t.string :description
      t.string :method

      t.timestamps
    end
  end
end
