class RenameGd < ActiveRecord::Migration
  def change
    rename_column :leaguerounds, :goal_differencet, :goal_difference
  end
end
