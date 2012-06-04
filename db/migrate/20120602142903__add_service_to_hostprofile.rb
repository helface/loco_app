class AddServiceToHostprofile < ActiveRecord::Migration
  def change
    add_column :hostprofiles, :service, :integer
  end
end
