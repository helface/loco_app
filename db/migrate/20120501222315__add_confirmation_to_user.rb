class AddConfirmationToUser < ActiveRecord::Migration
  def up
    change_table :users do |t|
      t.string :confirmation_token
      t.boolean :confirmed, default: false
    end
    add_index :users, :confirmation_token
  end
  
  def down
    change_table :users do |t|
      t.remove :confirmation_token
      t.remove :confirmed
    end
  end
  
end
