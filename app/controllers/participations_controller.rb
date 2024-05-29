class ParticipationsController < ApplicationController
    before_action :authenticate_user!
  
    def create
      @game = Game.find(params[:game_id])
      @participation = @game.participations.new(user: current_user)
  
      # Using the hardcoded question
      question_content = @game.questions.first
      question = Question.find_or_create_by(content: question_content, game: @game)
  
      # Ensure the question is saved
      unless question.persisted?
        flash[:alert] = "Error creating question."
        redirect_to game_path(@game) and return
      end
  
      # Create an answer associated with the participation
      answer = @participation.answers.build(question: question, content: params[:answer_content])
  
      if @participation.save
        redirect_to game_participation_path(@game, @participation)
      else
        logger.error "Error creating participation: #{@participation.errors.full_messages.join(", ")}"
        logger.error "Answer errors: #{answer.errors.full_messages.join(", ")}"
        flash[:alert] = 'There was an error creating your participation: ' + @participation.errors.full_messages.join(", ") + ' ' + answer.errors.full_messages.join(", ")
        redirect_to game_path(@game)
      end
    end
  
    def show
      @participation = Participation.find(params[:id])
      @game = @participation.game
  
      unless @participation.user == current_user
        redirect_to games_path, alert: 'You do not have access to this participation.'
      end
    end
  end