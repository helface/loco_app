class AddStatsToHostprofile < ActiveRecord::Migration
  def change
    add_column :hostprofiles, :recommend_count, :integer, default: 0
    add_column :hostprofiles, :unrecommend_count, :integer, default: 0
    add_column :hostprofiles, :contacted_count, :integer, default: 0
    add_column :hostprofiles, :responded_count, :integer, default: 0
  end
end
