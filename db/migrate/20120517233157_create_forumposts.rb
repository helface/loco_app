class CreateForumposts < ActiveRecord::Migration
  def change
    create_table :forumposts do |t|
      t.integer :user_id
      t.integer :city_id
      t.integer :country_id
      t.integer :responded_count, default: 0
      t.string :title
      t.string :content
      t.timestamps
    end
    
    add_index :forumposts, [:city_id, :created_at]
    add_index :forumposts, [:user_id, :created_at]
  end
end
