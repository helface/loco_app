class RemoveAboutMeFromHost < ActiveRecord::Migration
  def up
    remove_column :hostprofiles, :aboutme
  end

  def down
    add_column :hostprofiles, :aboutme, :string
  end
end
