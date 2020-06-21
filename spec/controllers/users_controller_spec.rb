# frozen_string_literal: true

require 'rails_helper'

describe UsersController do
  let(:user) { FactoryBot.create :user }
  let(:question_one) { FactoryBot.create :question, position: 4 }
  let(:question_two) { FactoryBot.create :question, position: 3 }
  let(:question_three) { FactoryBot.create :question, position: 2 }
  let(:question_four) { FactoryBot.create :question, position: 1  }
  let(:question_five) { FactoryBot.create :question, position: 0  }
  let(:awnser_one) { FactoryBot.create :awnser, :with_question, score: 10 }
  let(:awnser_two) { FactoryBot.create :awnser, :with_question, score: 15 }
  let(:awnser_three) { FactoryBot.create :awnser, :with_question, score: 5 }
  let(:awnser_four) { FactoryBot.create :awnser, :with_question, score: 20 }
  let(:awnser_five) { FactoryBot.create :awnser, :with_question, score: 10 }

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
        name = Faker::Name.name
        post :create, params: { user: { name: name } }
        user = User.find_by(name: name)

        expect(response).to redirect_to user_quiz_question_path(user, question_id: question_five.id)
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
    context 'with id params' do
      before { get :show, params: { id: user.id } }
      it 'assigns the requested users as @user' do
        expect(assigns(:user)).to eq user
      end

      it 'renders the show template' do
        expect(response).to render_template :show
      end
    end
  end

  describe '#GET quiz_question' do
    before { get :quiz_question, params: { id: user.id, question_id: question_one.id } }
    it 'assigns the requested user as @user' do
      expect(assigns(:user)).to eq user
    end

    it 'assigns the requested question as @question' do
      expect(assigns(:question)).to eq question_one
    end

    it 'renders the quiz_question template' do
      expect(response).to render_template :quiz_question
    end
  end

  describe '#POST quiz_awnser' do
    before do
      awnser_one
      awnser_two
      awnser_three
      awnser_four
      awnser_five
    end
    it 'assigns the requested user as @user' do
      post :quiz_awnser, params: { id: user.id, awnser_id: awnser_one.id }

      expect(assigns(:user)).to eq user
    end

    it 'adds the awnser to the user awnsers' do
      post :quiz_awnser, params: { id: user.id, awnser_id: awnser_one.id }
      user.reload

      expect(user.awnsers).to include awnser_one
    end

    context 'with a next question' do
      before { post :quiz_awnser, params: { id: user.id, awnser_id: awnser_one.id } }
      it 'redirects to the next user_quiz_question' do
        expect(response).to redirect_to user_quiz_question_path(user, question_id: awnser_two.question.id)
      end
    end

    context 'with the last question' do
      before { post :quiz_awnser, params: { id: user.id, awnser_id: awnser_five.id } }
      it 'redirects to the user_quiz_results' do
        expect(response).to redirect_to user_quiz_result_path(user)
      end
    end
  end

  describe '#GET quiz_result' do
    context 'with not special additions' do
      before { get :quiz_result, params: { id: user.id } }
      it 'assigns the requested user as @user' do
        expect(assigns(:user)).to eq user
      end

      it 'renders the quiz_result template' do
        expect(response).to render_template :quiz_result
      end
    end

    context 'when the quiz score is higher then the current highscore' do
      before do
        user.awnsers << awnser_one
        user.awnsers << awnser_two
        user.awnsers << awnser_three
        user.awnsers << awnser_four
        user.awnsers << awnser_five
        user.update(highscore: 50)
        get :quiz_result, params: { id: user.id }
        user.reload
      end
      it 'updates the user highscore the the quiz score' do
        expect(user.highscore).to eq 60
      end
    end
  end

  describe '#POST quiz_reset' do
    before do
      question_one
      question_two
      question_three
      question_four
      question_five
      post :quiz_reset, params: { id: user.id }
    end
    it 'deletes all the user awnsers from the database' do
      user.awnsers.reload

      expect(user.awnsers.count).to eq 0
    end

    it 'redirects to the first question' do
      expect(response).to redirect_to user_quiz_question_path(user, question_id: question_five.id)
    end
  end
end
