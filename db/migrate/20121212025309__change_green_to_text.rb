class ChangeGreenToText < ActiveRecord::Migration
  def up
    change_column :hostprofiles, :greenDesc, :text
  end

  def down
    change_column :hostprofiles, :greenDesc, :string
  end
end
