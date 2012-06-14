class AddLanguageToHostprofile < ActiveRecord::Migration
  def change
    add_column :hostprofiles, :languages, :string
  end
end
