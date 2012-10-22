class AddLanguageFlag < ActiveRecord::Migration
  def change
    add_column :hostprofiles, :languages_filled, :boolean, default: false
  end
end
