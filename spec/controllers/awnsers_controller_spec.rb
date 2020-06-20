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
      it 'assigsn the requested question as @question' do
        post :create, params: { question_id: question.id, awnser: { content: Faker::Lorem.sentence, score: Faker::Number.number(digits: 4) } }

        expect(assigns(:question)).to eq question
      end

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
      it 'does not save the new values to the database' do
        expect {
          post :create, params: { question_id: question.id, awnser: { content: '', score: Faker::Number.number(digits: 4) } }
        }.to change(Awnser, :count).by(0)
      end

      it 'assigsn the requested question as @question' do
        post :create, params: { question_id: question.id, awnser: { content: Faker::Lorem.sentence, score: Faker::Number.number(digits: 4) } }

        expect(assigns(:question)).to eq question
      end
    end
  end

  describe '#GET edit' do
    before { get :edit, params: { question_id: question.id, id: awnser_one.id } }
    it 'assigsn the requested question as @question' do
      expect(assigns(:question)).to eq question
    end

    it 'assigns the requested awnser as @anwser' do
      expect(assigns(:awnser)).to eq awnser_one
    end

    it 'renders the edit template' do
      expect(response).to render_template :edit
    end
  end

  describe '#PUT update' do
    context 'with valid params' do
      before { put :update, params: { question_id: question.id, id: awnser_one.id, awnser: { content: 'test update' } } }
      it 'updates the question with the new values' do
        awnser_one.reload

        expect(awnser_one.content).to eq 'test update'
      end
      
      it 'redirects to the question page' do
        expect(response).to redirect_to question
      end
    end

    context 'with invalid params' do
      before { put :update, params: { question_id: question.id, id: awnser_one.id, awnser: { content: '' } } }
      it 'does not save the new values to the database' do
        awnser_one.reload
        expect(awnser_one.content).to_not eq ''
      end

      it 'renders the edit template' do
        expect(response).to redirect_to question
      end
    end
  end

  describe '#DELETE destroy' do
    before { awnser_one }
    it 'assigsn the requested awnser as @anwser' do
      delete :destroy, params: { question_id: question.id, id: awnser_one.id }

      expect(assigns(:awnser)).to eq awnser_one
    end

    it 'removes the awnser from the database' do
      expect {
        delete :destroy, params: { question_id: question.id, id: awnser_one.id }
      }.to change(Awnser, :count).by(-1)
    end

    it 'redirects to the question page' do
      delete :destroy, params: { question_id: question.id, id: awnser_one.id }
      
      expect(response).to redirect_to question
    end
  end
end
