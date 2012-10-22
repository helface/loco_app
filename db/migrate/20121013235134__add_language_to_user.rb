class AddLanguageToUser < ActiveRecord::Migration
  def change
    add_column :users, :languages, :string
    add_column :users, :facebook, :string
  end
end
