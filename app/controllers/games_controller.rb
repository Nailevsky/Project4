class GamesController < ApplicationController
  before_action :set_game, only: [:show, :choose_player, :start_game]

  def show
    @game = Game.find(params[:id])
  end

  def start_game
    player_type = params[:player_type]
    rounds = params[:rounds].to_i

    session[:user_moves] = []
    session[:player_moves] = []
    session[:user_scores] = []
    session[:player_scores] = []
    session[:player] = create_player(player_type)

    @participation = Participation.create!(
      user: current_user,
      game: @game,
      rounds: rounds,
      player_type: player_type,
      user_score: 0,
      player_score: 0
    )

    redirect_to play_round_game_participation_path(@game, @participation, round: 1)
  end

  private

  def set_game
    @game = Game.find(params[:id])
  end

  def create_player(player_type)
    case player_type
    when 'always_cooperate'
      Players::AlwaysCooperate.new
    when 'always_betray'
      Players::AlwaysBetray.new
    when 'tit_for_tat'
      Players::TitForTat.new
    when 'random'
      Players::RandomPlayer.new
    else
      raise "Unknown player type: #{player_type}"
    end
  end
end