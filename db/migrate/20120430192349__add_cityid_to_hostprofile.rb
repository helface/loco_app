class AddCityidToHostprofile < ActiveRecord::Migration
  def change
    add_column :hostprofiles, :city_id, :integer
  end
end
