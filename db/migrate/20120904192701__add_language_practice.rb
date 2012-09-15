class AddLanguagePractice < ActiveRecord::Migration
  def change
    add_column :hostprofiles, :language_practice, :string
  end
end
