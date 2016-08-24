class UpdateSeason < ActiveRecord::Migration
  def change
    execute "update bets set seasonStartYear = '2014'"
    execute "update leagues set seasonStartYear = '2014'"
  end
end
