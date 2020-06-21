# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.create :user }
  let(:awnser_one) { FactoryBot.create :awnser, :with_question, score: 10 }
  let(:awnser_two) { FactoryBot.create :awnser, :with_question, score: 15 }
  let(:awnser_three) { FactoryBot.create :awnser, :with_question, score: 5 }
  let(:awnser_four) { FactoryBot.create :awnser, :with_question, score: 20 }
  let(:awnser_five) { FactoryBot.create :awnser, :with_question, score: 10 }
  let(:new_awnser) { FactoryBot.create :awnser, question: awnser_one.question }

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

  describe '#process_awnser' do
    context 'with an question awnser already present' do
      before do
        user.awnsers << awnser_one
        new_awnser
      end
      it 'is expected that the user before has 1 question awnser' do
        expect(user.awnsers.count).to eq 1
      end

      it 'replaces the question awnser with the new new awnser' do
        user.process_awnser(new_awnser)

        expect(user.awnsers).to include new_awnser
        expect(user.awnsers).to_not include awnser_one
      end
    end

    context 'with an new question awnser' do
      it 'add the new question awnser to the user awnsers' do
        user.process_awnser(new_awnser)

        expect(user.awnsers).to include new_awnser
      end
    end
  end
end
