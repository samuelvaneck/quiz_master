# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, except: [:new, :create]
  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      @question = Question.all.min_by(&:position)
      redirect_to user_quiz_question_path(@user, question_id: @question.id)
    else
      render :new
    end
  end

  def show
    @user = User.find params[:id]
    respond_with @user
  end

  def quiz_question
    @question = Question.find params[:question_id]
  end

  def quiz_awnser
    @user = User.find params[:id]
    awnser = Awnser.find params[:awnser_id]
    # remove any previous awnsers
    @user.awnsers.delete(awnser) if @user.awnsers.present? && @user&.awnsers&.find(awnser.id)&.present?
    # add the new awnser
    @user.awnsers << awnser

    if params[:next_question].present?
      next_question = Question.find params[:next_question]
      redirect_to user_quiz_question_path(@user, question_id: next_question.id)
    else
      render quiz_results
    end
  end

  def quiz_result
    @user = User.find params[:id]
  end

  private

  def user_params
    params.require(:user).permit(:name)
  end

  def set_user
    @user = User.find params[:id]
  end
end
