class AddGroupSizeToAppt < ActiveRecord::Migration
  def change
    add_column :appointments, :groupsize, :integer, :default=>1
  end
end
