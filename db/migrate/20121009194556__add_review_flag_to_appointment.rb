class AddReviewFlagToAppointment < ActiveRecord::Migration
  def change
    add_column :appointments, :host_completed, :boolean, default: false
    add_column :appointments, :traveler_completed, :boolean, default: false
  end
end
