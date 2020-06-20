# frozen_string_literal: true

require 'rails_helper'

describe UsersController do
  let(:user) { FactoryBot.create :user }

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
      it 'creates a new user' do
        expect {
          post :create, params: { user: { name: Faker::Name.name } }
        }.to change(User, :count).by(1)
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
