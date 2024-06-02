class UsersController < ApplicationController
    def show
      @user = User.find(params[:id])
      @participations = @user.participations.includes(:game)
    end
  end  