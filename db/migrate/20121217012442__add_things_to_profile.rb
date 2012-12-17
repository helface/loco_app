class AddThingsToProfile < ActiveRecord::Migration
  def change
    add_column :hostprofiles, :money_cover, :text, limit:nil
    add_column :hostprofiles, :prof_exp, :text, limit:nil
  end
end
