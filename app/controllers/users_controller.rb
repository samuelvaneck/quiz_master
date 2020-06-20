# frozen_string_literal: true

class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      @question = Question.all.min_by(&:position)
      respond_with @question
    else
      render :new
    end
  end

  def show
    @user = User.find params[:id]
    respond_with @user
  end

  private

  def user_params
    params.require(:user).permit(:name)
  end
end
