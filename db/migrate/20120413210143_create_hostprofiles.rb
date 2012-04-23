class CreateHostprofiles < ActiveRecord::Migration
  def change
    create_table :hostprofiles do |t|
      t.string :tele
      t.text :serviceDesc
      t.string :aboutme
      t.string :price
      t.string :greenDesc

      t.timestamps
    end
  end
end
