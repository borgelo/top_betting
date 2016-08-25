class FixColumnNames < ActiveRecord::Migration
  def change
    rename_column :bets, :seasonStartYear, :seasonstartyear
    rename_column :leagues, :seasonStartYear, :seasonstartyear
  end
end
