# frozen_string_literal: true

class AwnsersController < ApplicationController
  before_action :set_question

  def new
    @awnser = @question.awnsers.build
  end

  def create
    @awnser = @question.awnsers.create(awnser_params)
    respond_with @question
  end

  def edit
    
  end

  def update

  end

  def destroy

  end

  private

  def awnser_params
    params.require(:awnser).permit(:content, :score, :question_id)
  end

  def set_question
    @question = Question.find params[:question_id]
  end
end
