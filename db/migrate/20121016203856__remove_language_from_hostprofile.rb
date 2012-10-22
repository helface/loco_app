class RemoveLanguageFromHostprofile < ActiveRecord::Migration
  change_table :hostprofiles do |t|
    t.remove  :languages
  end
end
