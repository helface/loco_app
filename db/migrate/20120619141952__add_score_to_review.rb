class AddScoreToReview < ActiveRecord::Migration
  def change
    add_column :reviews, :score, :integer, :default=>0
    add_column :reviews, :recommend, :boolean
  end
end
