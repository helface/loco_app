class ChangeMsgthreadParnames < ActiveRecord::Migration
  def change
     change_table :msgthreads do |t|
       t.rename :recipient_id, :participant1_id
       t.rename :sender_id, :participant2_id
     end
   end
end
