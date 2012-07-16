class AddReviewType < ActiveRecord::Migration
  def change
    add_column :reviews, :is_host_review, :boolean
    add_column :reviews, :guest_score, :float
  end
end
