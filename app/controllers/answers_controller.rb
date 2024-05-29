class AnswersController < ApplicationController
    before_action :authenticate_user!
  
    def new
      @participation = Participation.find(params[:participation_id])
      @question = @participation.game.questions.first
      @answer = @participation.answers.new
    end
  
    def create
      @participation = Participation.find(params[:participation_id])
      @answer = @participation.answers.create(answer_params)
      if @answer.save
        redirect_to game_participation_path(@participation.game, @participation)
      else
        render :new
      end
    end
  
    private
  
    def answer_params
      params.require(:answer).permit(:content, :question_id)
    end
  end