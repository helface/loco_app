class AddSubjectToMsgthreads < ActiveRecord::Migration
  def change
    add_column :msgthreads, :subject, :string
  end
end
