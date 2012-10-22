class AddFlexToAppointment < ActiveRecord::Migration
  def change
    add_column :appointments, :flexible, :boolean
  end
end
