# frozen_string_literal: true

require 'rails_helper'

RSpec.describe QuestionsController do
  let(:question_one) { FactoryBot.create :question, position: 0 }
  let(:question_two) { FactoryBot.create :question, position: 1 }
  let(:question_three) { FactoryBot.create :question, position: 2 }

  before do
    question_one
    question_two
    question_three
  end

  describe '#GET index' do
    before { get :index }
    it 'assigns all questions as @questions' do
      expect(assigns(:questions)).to eq [question_one, question_two, question_three]
    end

    it 'sorts all question by postion' do
      expect(assigns(:questions).map(&:position)).to eq [0, 1, 2]
    end

    it 'renders the index template' do
      expect(response).to render_template :index
    end
  end

  describe '#GET new' do
    before { get :new }
    it 'assigns a new Qeustion as @question' do
      expect(assigns(:question)).to be_a_new Question
    end

    it 'assigns an unsaved question' do
      expect(assigns(:question)).to_not be_persisted
    end

    it 'renders the new template' do
      expect(response).to render_template :new
    end
  end
end
