class AddIndexRestrictions < ActiveRecord::Migration
  def change
    remove_index :restrictions, name: 'index_restrictions_uniq'
    add_index :restrictions, [:hotel_id, :rate_id, :room_type_id, :type_id,  :date], unique: true, name: 'index_restrictions_uniq'
  end
end
