# frozen_string_literal: true

class QuestionsController < ApplicationController

  def index
    @questions = Question.all.sort_by(&:position)
  end

  def show

  end

  def new

  end

  def create

  end

  def edit

  end

  def update

  end

  def destroy

  end

  private

  def question_params
    params.require(:question).permit(:content)
  end

  def set_question
    @question = Question.find(params[:id])
  end
end
