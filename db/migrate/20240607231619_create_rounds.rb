class CreateRounds < ActiveRecord::Migration[7.1]
  def change
    create_table :rounds do |t|
      t.references :participation, null: false, foreign_key: true
      t.string :user_move
      t.string :player_move

      t.timestamps
    end
  end
end
