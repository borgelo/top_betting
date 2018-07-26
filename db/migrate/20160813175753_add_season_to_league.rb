class AddSeasonToLeague < ActiveRecord::Migration
  def change
    add_column :leagues, :seasonStartYear, :integer
  end
end
