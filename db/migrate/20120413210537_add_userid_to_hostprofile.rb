class AddUseridToHostprofile < ActiveRecord::Migration
  def change
    add_column :hostprofiles, :user_id, :integer
    add_index :hostprofiles, :user_id
  end
end
