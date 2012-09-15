class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.integer :traveler_id
      t.integer :host_id
      t.text :message, :limit=>400
      t.date :date
      t.string :time
      t.integer :status
      t.timestamps
    end
  end
end
