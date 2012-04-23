class AddHostidToReview < ActiveRecord::Migration
  def change
      add_column :reviews, :host_id, :integer
      add_index :reviews, [:host_id, :created_at]
  end
end
