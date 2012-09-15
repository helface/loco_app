class AddTimeToPost < ActiveRecord::Migration
  def change
    add_column :forumposts, :time, :string
    add_column :forumposts, :date, :date
  end
end
