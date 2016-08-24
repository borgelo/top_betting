class UpdateSeason < ActiveRecord::Migration
  def change
    execute "UPDATE bets SET seasonStartYear = '2014'"
    execute "UPDATE leagues SET seasonStartYear = '2014'"
  end
end
