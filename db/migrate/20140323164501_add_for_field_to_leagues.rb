class AddForFieldToLeagues < ActiveRecord::Migration
  def change
    add_column :leagues, :for, :integer
  end
end
