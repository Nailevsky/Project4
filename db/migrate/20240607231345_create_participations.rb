class CreateParticipations < ActiveRecord::Migration[7.1]
  def change
    create_table :participations do |t|
      t.references :user, null: false, foreign_key: true
      t.references :game, null: false, foreign_key: true
      t.integer :rounds
      t.string :player_type
      t.integer :user_score
      t.integer :player_score

      t.timestamps
    end
  end
end