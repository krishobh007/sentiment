class AddColumnCodeToCountries < ActiveRecord::Migration
  def change
    add_column :countries, :code, :string
  end
end
