class ChangeReviewParameters < ActiveRecord::Migration
  def change
    change_table :reviews do |t|
      t.rename :host_id, :reviewee_id
      t.rename :use_id, :reviewer_id
    end
  end
end
