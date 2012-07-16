class AddQsToReviews < ActiveRecord::Migration
  def up
    add_column :reviews, :accuracy, :integer, default: 0
    add_column :reviews, :enjoybility, :integer, default: 0
    add_column :reviews, :easiness, :integer, default: 0
    add_column :reviews, :friendliness, :integer, default: 0
    remove_column :reviews, :score
  end

  def down
    remove_column :reviews, :accuracy
    remove_column :reviews, :enjoybility
    remove_column :reviews, :easiness
    remove_column :reviews, :accuracy
    remove_column :reviews, :friendliness
  end
end
