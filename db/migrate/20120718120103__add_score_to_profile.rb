class AddScoreToProfile < ActiveRecord::Migration
  def change
    add_column :hostprofiles, :score, :float, :default=>0
  end
end
