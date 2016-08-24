class UpdateSeason < ActiveRecord::Migration
  def change
    execute "update bet set seasonStartYear = '2014'"
    execute "update league set seasonStartYear = '2014'"
  end
end
