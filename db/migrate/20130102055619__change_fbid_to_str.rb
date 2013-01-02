class ChangeFbidToStr < ActiveRecord::Migration
  def up
    change_column :users, :fb_id, :string
    
  end

  def down
    change_column :users, :fb_id, :integer
  end
end
