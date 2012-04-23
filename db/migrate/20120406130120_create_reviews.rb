class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :content
      t.integer :use_id

      t.timestamps
    end
    
      add_index :reviews, [:user_id, :host_id, :created_at]
  end
end
