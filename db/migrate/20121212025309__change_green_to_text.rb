class ChangeGreenToText < ActiveRecord::Migration
  def up
    change_column :hostprofiles, :greenDesc, :text, limit: nil
    change_column :forumposts, :content, :text, limit: nil
    change_column :reviews, :content, :text, limit: nil
    change_column :travelerreviews, :comment, :text, limit: nil
    change_column :users, :self_intro, :text, limit:nil
    
    
  end

  def down
    change_column :hostprofiles, :greenDesc, :string
    change_column :forumposts, :content, :string
    change_column :reviews, :content, :string
    change_column :travelerreviews, :comment, :string
    change_column :users, :self_intro, :string
    
  end
end
