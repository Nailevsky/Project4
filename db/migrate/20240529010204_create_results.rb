class CreateResults < ActiveRecord::Migration[7.0]
  def change
    create_table :results do |t|
      t.integer :score
      t.string :outcome
      t.references :participation, null: false, foreign_key: true

      t.timestamps
    end
  end
end