class AddCompletionToHostprofile < ActiveRecord::Migration
  def change
    add_column :hostprofiles, :completed_count, :integer, :default=>0
  end
end
