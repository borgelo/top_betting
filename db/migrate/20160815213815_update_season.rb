class UpdateSeason < ActiveRecord::Migration
  def change
    execute "UPDATE Bets SET seasonStartYear = '2014';"
    execute "UPDATE Leagues SET seasonStartYear = '2014';"
  end
end
