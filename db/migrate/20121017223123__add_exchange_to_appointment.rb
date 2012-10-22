class AddExchangeToAppointment < ActiveRecord::Migration
  def change
    add_column :appointments, :exchange_type, :string
    add_column :appointments, :price, :integer
    add_column :appointments, :currency, :string
    add_column :appointments, :language_practice, :string 
  end
end
