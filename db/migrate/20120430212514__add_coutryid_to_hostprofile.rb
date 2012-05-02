class AddCoutryidToHostprofile < ActiveRecord::Migration
  def change
    add_column :hostprofiles, :country_id, :integer
  end
end
