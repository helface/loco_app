class AddMoneyAndFilledToRequest < ActiveRecord::Migration
  def change
    add_column :forumposts, :pay, :boolean, default: false
    add_column :forumposts, :currency, :string
    add_column :forumposts, :filled, :boolean, default: false
    add_column :forumposts, :price, :integer
  end
end
