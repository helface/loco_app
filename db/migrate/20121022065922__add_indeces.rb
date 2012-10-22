class AddIndeces < ActiveRecord::Migration
  def change
    add_index :appointments, [:status, :date, :exchange_type]
    add_index :hostprofiles, :deactivated
    add_index :reviews, :reviewee_id
    add_index :travelerreviews, :reviewee_id
    add_index :msgthreads, [:participant1_id, :participant2_id]
    add_index :images, :user_id
    add_index :messages, [:sender_id, :recipient_id]
    add_index :forumposts, [:date, :created_at]
  end
end