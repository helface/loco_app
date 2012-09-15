class AddThingsToUser < ActiveRecord::Migration
  def change
    add_column :users, :completed_count, :integer, default: 0
    add_column :users, :self_intro, :string, default: ""
  end
end
