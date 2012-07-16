class AddCurrencyToHostprofile < ActiveRecord::Migration
  def change
    change_table :hostprofiles do |t|
        t.rename :other_exchange, :exchange_type
        t.string :currency
    end
  end
end
