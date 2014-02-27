class CreateBets < ActiveRecord::Migration
  def change
    create_table :bets do |t|
      t.references :user, index: true
      t.references :league, index: true
      t.integer :position

      t.timestamps
    end
  end
end
