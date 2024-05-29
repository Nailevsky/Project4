class Participation < ApplicationRecord
  belongs_to :user
  belongs_to :game
  has_many :answers
  has_one :result

  after_create :evaluate_result

  validates :user, presence: true
  validates :game, presence: true

  private

  def evaluate_result
    game_results = game.evaluate_game(game.participations)

    game.participations.each_with_index do |participation, index|
      if participation.result
        participation.result.update(outcome: game_results[index])
      else
        participation.create_result(outcome: game_results[index])
      end
    end
  end
end