class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :title
      t.string :desc

      t.timestamps
    end
  end
end
