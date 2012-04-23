class RenameReviewIndex < ActiveRecord::Migration
  def change
    rename_index :reviews, 'index_reviews_on_use_id_and_created_at', 'index_reviews_on_reviewer_id_and_created_at'
    rename_index :reviews, 'index_reviews_on_host_id_and_created_at', 'index_reviews_on_reviewee_id_and_created_at'
  end
end
