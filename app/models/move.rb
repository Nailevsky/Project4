class Move < ApplicationRecord
  belongs_to :player
  belongs_to :game
  belongs_to :participation
end