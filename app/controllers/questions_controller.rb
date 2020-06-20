# frozen_string_literal: true

class QuestionsController < ApplicationController
  before_action :set_question, except: [:index, :new, :create]
  def index
    @questions = Question.all.sort_by(&:position)
  end

  def show; end

  def new
    @question = Question.new
  end

  def create
    @question = Question.create(question_params)
    respond_with @question
  end

  def edit; end

  def update
    @question.update question_params
    respond_with @question
  end

  def destroy
    @question.destroy
    redirect_to questions_path
  end

  private

  def question_params
    params.require(:question).permit(:content, :position, awnsers_attributes: [:content, :score])
  end

  def set_question
    @question = Question.find(params[:id])
  end
end
