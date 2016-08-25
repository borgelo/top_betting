class FixColumnNames < ActiveRecord::Migration
  def change
    rename_column :Bets, :seasonStartYear, :seasonstartyear
    rename_column :Leagues, :seasonStartYear, :seasonstartyear
  end
end
