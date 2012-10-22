class AddScoreToUser < ActiveRecord::Migration
  def change
    add_column :users, :traveler_score, :float, default: 0
  end
end
