class GamesController < ApplicationController
  before_action :set_game, only: [:show, :choose_player, :start_game]

  def show
  end

  def choose_player
  end

  def start_game
    @participation = Participation.create!(
      user: current_user,
      game: @game,
      rounds: params[:rounds].to_i,
      player_type: params[:player_type],
      user_score: 0,
      player_score: 0
    )

    session[:user_moves] = []
    session[:player_moves] = []
    session[:player_type] = params[:player_type]

    redirect_to play_round_game_participation_path(@participation.game, @participation, round: 1)
  end

  private

  def set_game
    @game = Game.find(params[:id])
  end
end