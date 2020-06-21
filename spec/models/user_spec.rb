# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) {FactoryBot.create :user }
  let(:awnser_one) { FactoryBot.create :awnser, :with_question, score: 10 }
  let(:awnser_two) { FactoryBot.create :awnser, :with_question, score: 15 }
  let(:awnser_three) { FactoryBot.create :awnser, :with_question, score: 5 }
  let(:awnser_four) { FactoryBot.create :awnser, :with_question, score: 20 }
  let(:awnser_five) { FactoryBot.create :awnser, :with_question, score: 10 }

  describe '#quiz_score' do
    before do
      user.awnsers << awnser_one
      user.awnsers << awnser_two
      user.awnsers << awnser_three
      user.awnsers << awnser_four
      user.awnsers << awnser_five
    end
    it 'adds up all the scrore from the user awnsers' do
      expect(user.quiz_score).to eq 60
    end
  end
end
