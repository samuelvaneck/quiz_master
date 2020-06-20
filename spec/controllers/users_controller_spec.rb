# frozen_string_literal: true

require 'rails_helper'

describe UsersController do
  let(:user) { FactoryBot.create :user }

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
