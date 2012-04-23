class ChangeReviewParameters < ActiveRecord::Migration
  def change
    change_table :reviews do |t|
      t.rename :user_id, :reviewer_id
      t.rename :host_id, :reviewee_id
    end
  end
end
