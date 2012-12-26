class AddFbprofilePic < ActiveRecord::Migration
  def change
    add_column :users, :fb_profilepic_url, :string
  end
end
