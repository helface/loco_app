class AddThreadidToMessage < ActiveRecord::Migration
  def change
    add_column :messages, :thread_id, :integer
  end
end
