class ParticipationsController < ApplicationController
  before_action :set_participation, only: [:show, :play_round, :update_round]

  def show
    @user_score = @participation.user_score
    @player_score = @participation.player_score
  end

  def play_round
    @round = params[:round].to_i
    @user_move = session[:user_moves][@round - 1] if @round > 1
    @player_move = session[:player_moves][@round - 1] if @round > 1
  end

  def update_round
    @round = params[:round].to_i
    user_move = params[:move]

    player = create_player(session[:player_type])
    player_move = player.make_move(@round, session[:user_moves])

    session[:user_moves] << user_move
    session[:player_moves] << player_move

    calculate_scores(user_move, player_move)

    if @round >= @participation.rounds
      redirect_to game_participation_path(@participation.game, @participation)
    else
      redirect_to play_round_game_participation_path(@participation.game, @participation, round: @round + 1)
    end
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
    case [user_move, player_move]
    when ['cooperate', 'cooperate']
      @participation.user_score += 3
      @participation.player_score += 3
    when ['cooperate', 'betray']
      @participation.user_score += 0
      @participation.player_score += 5
    when ['betray', 'cooperate']
      @participation.user_score += 5
      @participation.player_score += 0
    when ['betray', 'betray']
      @participation.user_score += 1
      @participation.player_score += 1
    end

    @participation.save
  end
end