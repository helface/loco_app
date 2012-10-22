class CreateTravelerreviews < ActiveRecord::Migration
  def change
    create_table :travelerreviews do |t|
      t.string :comment
      t.integer :score
      t.integer :reviewer_id
      t.integer :reviewee_id
      t.timestamps
    end
  end
end
