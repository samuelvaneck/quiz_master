# frozeon_sting_literal: true

require 'rails_helper'

RSpec.describe AwnsersController do
  let(:question) { FactoryBot.create :question }
  let(:awnser_one) { FactoryBot.create :awnser, question: question }
  let(:awnser_two) { FactoryBot.create :awnser, question: question }
  let(:awnser_three) { FactoryBot.create :awnser, question: question }

  describe '#GET new' do
    before { get :new, params: { question_id: question.id } }
    it 'assigsn the requested question as @question' do
      expect(assigns(:question)).to eq question
    end

    it 'assigns a new awnser as @awnser' do
      expect(assigns(:awnser)).to be_a_new Awnser
    end

    it 'does not save the awser' do
      expect(assigns(:awnser)).to_not be_persisted
    end

    it 'renders the new template' do
      expect(response).to render_template :new
    end
  end

  describe '#POST create' do
    context 'with valid params' do
      it 'saves the new awsner to the database' do
        expect {
          post :create, params: { question_id: question.id, awnser: { content: Faker::Lorem.sentence, score: Faker::Number.number(digits: 4) } }
        }.to change(Awnser, :count).by(1)
      end

      it 'redirects to the question' do
        post :create, params: { question_id: question.id, awnser: { content: Faker::Lorem.sentence, score: Faker::Number.number(digits: 4) } }

        expect(response).to redirect_to question
      end
    end

    context 'with invalid params' do
      
    end
  end
end