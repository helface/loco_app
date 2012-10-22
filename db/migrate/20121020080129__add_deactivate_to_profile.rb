class AddDeactivateToProfile < ActiveRecord::Migration
  def change
    add_column :hostprofiles, :deactivated, :boolean, default: false
  end
end
