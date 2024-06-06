class ParticipationsController < ApplicationController
  before_action :set_participation, only: [:show, :play_round, :update_round, :restart]

  def show
    @user_score = @participation.user_score
    @player_score = @participation.player_score
  end

  def play_round
    @round = params[:round].to_i
    if @round > 1
      @user_move = session[:user_moves][@round - 2]
      @player_move = session[:player_moves][@round - 2]
      @previous_user_score = session[:user_scores][@round - 2] || 0
      @previous_player_score = session[:player_scores][@round - 2] || 0
    end
    @user_score = @participation.user_score
    @player_score = @participation.player_score
  end

  def update_round
    @round = params[:round].to_i
    user_move = params[:move]

    player = create_player(@participation.player_type)
    player_move = player.make_move(@round, session[:user_moves])

    session[:user_moves] << user_move
    session[:player_moves] << player_move

    user_round_score, player_round_score = calculate_scores(user_move, player_move)
    session[:user_scores] << user_round_score
    session[:player_scores] << player_round_score

    @participation.user_score += user_round_score
    @participation.player_score += player_round_score
    @participation.save

    if @round >= @participation.rounds
      redirect_to game_participation_path(@participation.game, @participation)
    else
      redirect_to play_round_game_participation_path(@participation.game, @participation, round: @round + 1)
    end
  end

  def restart
    @participation.update(user_score: 0, player_score: 0)
    session[:user_moves] = []
    session[:player_moves] = []
    session[:user_scores] = []
    session[:player_scores] = []

    redirect_to play_round_game_participation_path(@participation.game, @participation, round: 1)
  end

  private

  def set_participation
    @participation = Participation.find(params[:id])
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

  def calculate_scores(user_move, player_move)
    user_round_score, player_round_score = case [user_move, player_move]
    when ['cooperate', 'cooperate']
      [3, 3]
    when ['cooperate', 'betray']
      [0, 5]
    when ['betray', 'cooperate']
      [5, 0]
    when ['betray', 'betray']
      [1, 1]
    end
    [user_round_score, player_round_score]
  end
end