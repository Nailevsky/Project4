class CreateMoves < ActiveRecord::Migration[7.1]
  def change
    create_table :moves do |t|
      t.string :player_type 
      t.references :game, null: false, foreign_key: true
      t.integer :round
      t.string :move

      t.timestamps
    end
  end
end
