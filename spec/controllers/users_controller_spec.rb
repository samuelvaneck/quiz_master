# frozen_string_literal: true

require 'rails_helper'

describe UsersController do
  let(:user) { FactoryBot.create :user }
  let(:question_one) { FactoryBot.create :question, position: 4 }
  let(:question_two) { FactoryBot.create :question, position: 3 }
  let(:question_three) { FactoryBot.create :question, position: 2 }
  let(:question_four) { FactoryBot.create :question, position: 1  }
  let(:question_five) { FactoryBot.create :question, position: 0  }

  describe 'GET #new' do
    before { get :new }
    it 'assigns a new unsaved user as @user' do
      expect(assigns(:user)).to be_a_new User
    end

    it 'assigns an unsaved User' do
      expect(assigns(:user)).to_not be_persisted
    end

    it 'renders the new template' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      before do
        question_one
        question_two
        question_three
        question_four
        question_five
      end
      it 'creates a new user' do
        expect {
          post :create, params: { user: { name: Faker::Name.name } }
        }.to change(User, :count).by(1)
      end

      it 'renders the first quiz question (with the lowest postion)' do
        post :create, params: { user: { name: Faker::Name.name } }

        expect(response).to redirect_to question_five
      end
    end

    context 'with invalid params' do
      it 'does not create a user' do
        expect {
          post :create, params: { user: { name: '' } }
        }.to change(User, :count).by(0)
      end

      it 'renders the new template' do
        post :create, params: { user: { name: '' } }

        expect(response).to render_template :new
      end
    end
  end

  describe 'GET #show' do
    before { user }
    context 'with id params' do
      it 'assigns the requested users as @user' do
        get :show, params: { id: user.id }

        expect(assigns(:user)).to eq user
      end
    end
  end
end
