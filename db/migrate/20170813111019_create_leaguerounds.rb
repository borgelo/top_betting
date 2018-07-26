class CreateLeaguerounds < ActiveRecord::Migration
  def change
    create_table :leaguerounds do |t|
      t.string :name
      t.integer :position
      t.integer :played
      t.integer :win
      t.integer :drawn
      t.integer :lost
      t.integer :against
      t.integer :goal_differencet
      t.integer :points
      t.integer :for
      t.integer :seasonstartyear
      t.timestamps

    end
  end
end
