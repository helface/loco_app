class AddShortMsgToProfile < ActiveRecord::Migration
  def change
    add_column :hostprofiles, :intro, :string
  end
end
