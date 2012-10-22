class RemoveCaptionFrom < ActiveRecord::Migration
  change_table :images do |t|
    t.remove  :caption
  end
end
