class DropMailboxTable < ActiveRecord::Migration
  def up
    drop_table :mailboxes
  end

  def down
    create_table :mailboxes do |t|
      t.integer :user_id
      t.timestamps
    end
  end
end
