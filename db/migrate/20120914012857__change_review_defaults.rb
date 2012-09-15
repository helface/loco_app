class ChangeReviewDefaults < ActiveRecord::Migration
  def change
    change_column :reviews, :accuracy, :integer, default: nil
    change_column :reviews, :friendliness, :integer, default: nil
    change_column :reviews, :enjoybility, :integer, default: nil
    change_column :reviews, :easiness, :integer, default: nil    
  end
end
