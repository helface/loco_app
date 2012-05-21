class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.integer :user_id
      t.string :caption

      t.timestamps
    end
  end
end
