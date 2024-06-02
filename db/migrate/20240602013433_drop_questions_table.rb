class DropQuestionsTable < ActiveRecord::Migration[7.1]
  def up
    drop_table :questions
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end