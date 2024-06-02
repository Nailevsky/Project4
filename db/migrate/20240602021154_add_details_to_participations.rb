class AddDetailsToParticipations < ActiveRecord::Migration[7.1]
  def change
    add_column :participations, :rounds, :integer
    add_column :participations, :player_type, :string
    add_column :participations, :user_score, :integer
    add_column :participations, :player_score, :integer
  end
end
