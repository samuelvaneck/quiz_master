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
    awnser = Awnser.find params[:awnser_id]
    question = awnser.question
    @user.process_awnser awnser

    if question.next_question?
      redirect_to user_quiz_question_path(@user, question_id: question.next_question.id)
    else
      redirect_to user_quiz_result_path(@user)
    end
  end

  def quiz_result; end

  def quiz_reset
    @user.quiz_reset
    @question = Question.all.min_by(&:position)

    redirect_to  user_quiz_question_path(@user, question_id: @question.id)
  end

  private

  def user_params
    params.require(:user).permit(:name)
  end

  def set_user
    @user = User.find params[:id]
  end
end
