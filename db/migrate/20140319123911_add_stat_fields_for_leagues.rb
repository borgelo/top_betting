class AddStatFieldsForLeagues < ActiveRecord::Migration
  def change
    add_column :leagues, :played, :integer
    add_column :leagues, :win, :integer
    add_column :leagues, :drawn, :integer
    add_column :leagues, :lost, :integer
    add_column :leagues, :against, :integer
    add_column :leagues, :goal_difference, :integer
    add_column :leagues, :points, :integer    
  end
end
