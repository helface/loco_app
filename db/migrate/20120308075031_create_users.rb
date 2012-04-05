class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :firstname
      t.string :lastname
      t.string :email
        
      t.timestamps
    end
    
    change_table :users do |t|
        t.remove username
        t.index email
    end
      
  end
end
    
