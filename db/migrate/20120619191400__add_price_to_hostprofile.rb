class AddPriceToHostprofile < ActiveRecord::Migration
  def change
     change_table :hostprofiles do |t|
       t.rename :price, :other_exchange
       t.integer :price
     end
   end
end
