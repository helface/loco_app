class ChangeGreenToText < ActiveRecord::Migration
  def up
    change_column :hostprofiles, :greenDesc, :text, limit: nil
    
  end

  def down
    change_column :hostprofiles, :greenDesc, :string
  end
end
