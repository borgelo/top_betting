class AddSeasonToBet < ActiveRecord::Migration
  def change
    add_column :bets, :seasonStartYear, :integer
  end
end
