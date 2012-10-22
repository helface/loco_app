class RemoveLimitFromAppointment < ActiveRecord::Migration
  def change
    change_column :appointments, :message, :text, limit: nil
  end
end
