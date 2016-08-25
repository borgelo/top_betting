class UpdateSeason < ActiveRecord::Migration
  def change
    execute 'update Bets set "seasonStartYear" = 2014'
    execute 'update Leagues set "seasonStartYear" = 2014'
    seasonStartYear
  end
end
