class CreateGames < ActiveRecord::Migration[7.1]
  def change
    create_table :games do |t|
      t.string :title

      t.timestamps
    end

    # Adds a game after the table is created
    reversible do |dir|
      dir.up do
        Game.create!(title: "Prisoner's Dilemma")
      end
    end
  end
end