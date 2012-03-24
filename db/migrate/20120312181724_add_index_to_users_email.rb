class AddIndexToUsersEmail < ActiveRecord::Migration
  def change
    add_index :email, unique: true
  end
end
