class AddIndeces < ActiveRecord::Migration
  def change
    add_index :appointments, [:status, :date] 
    add_index :hostprofiles, :exchange_type
    add_index :hostprofiles, :deactivated
    add_index :reviews, :reviewee_id
    add_index :travelerreviews, :reviewee_id
    add_index :images, :user_id
    add_index :messages, [:sender_id, :created_at]
    add_index :messages, [:recipient_id, :created_at]
    add_index :forumposts, :date 
    add_index :forumposts, :created_at
  end
end