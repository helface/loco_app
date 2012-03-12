class AddIndexToUsersEmail < ActiveRecord::Migration
  def change
    add_index :email, :username, unique: true
  end
end
