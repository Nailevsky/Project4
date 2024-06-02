class Participation < ApplicationRecord
  belongs_to :user
  belongs_to :game

  validates :rounds, presence: true
  validates :player_type, presence: true
  validates :user_score, presence: true
  validates :player_score, presence: true

end