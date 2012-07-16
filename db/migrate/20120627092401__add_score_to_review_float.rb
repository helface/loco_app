class AddScoreToReviewFloat < ActiveRecord::Migration
  def change
    add_column :reviews, :score, :float
  end
end
