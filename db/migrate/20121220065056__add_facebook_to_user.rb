class AddFacebookToUser < ActiveRecord::Migration
   change_table :users do |t|
      t.string :provider
      t.integer :fb_id
      t.string :fb_token
      t.datetime :fb_expires_at
    end
end
