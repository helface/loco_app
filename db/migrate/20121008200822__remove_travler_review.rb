class RemoveTravlerReview < ActiveRecord::Migration
  change_table :reviews do |t|
    t.remove  :is_host_review, :guest_score
  end
end
