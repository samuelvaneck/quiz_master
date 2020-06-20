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

  describe '#GET show' do
    before { get :show, params: { id: question_one.id } }
    it 'assigns the request question by id as @question' do
      expect(assigns(:question)).to eq question_one
    end

    it 'renders the show template' do
      expect(response).to render_template :show
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

  describe '#POST create' do
    context 'with valid params' do
      it 'saved the question to the database' do
        expect {
          post :create, params: { question: { content: Faker::Lorem.sentence, position: Faker::Number.number(digits: 4) } }
        }.to change(Question, :count).by(1)
      end
    end

    context 'with invalid params' do
      it 'does not save the question to the database' do
        expect {
          post :create, params: { question: { content: nil, position: Faker::Number.digit } }
        }.to change(Question, :count).by(0)
      end
    end
  end
end
