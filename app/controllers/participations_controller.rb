class ParticipationsController < ApplicationController
    before_action :authenticate_user!
  
    def create
      @game = Game.find(params[:game_id])
      @participation = @game.participations.create(user: current_user)
      redirect_to @game, notice: "You have started a new participation."
    end
  
    def show
      @participation = Participation.find(params[:id])
      # Ensure the participation belongs to the current user
      unless @participation.user == current_user
        redirect_to games_path, alert: "You do not have access to this participation."
      end
    end
  end