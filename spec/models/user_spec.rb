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

  describe '#quiz_reset' do
    it 'removes all all awnsers from the user' do
      user.quiz_reset
      user.awnsers.reload

      expect(user.awnsers.count).to eq 0
    end
  end

  describe '#process_quiz_score' do
    before do
      user.awnsers << awnser_one
      user.awnsers << awnser_two
      user.awnsers << awnser_three
      user.awnsers << awnser_four
      user.awnsers << awnser_five
    end
    context 'when the quiz score is higher then the user highscore' do
      before do
        user.update(highscore: 50)
        user.reload
      end
      it 'updates the user highscore with the quiz score' do
        user.process_quiz_score
        user.reload

        expect(user.highscore).to eq 60
      end
    end

    context 'when the quiz score is lower then or equal to the user highscore' do
      before do
        user.update(highscore: 100)
        user.reload
      end
      it 'does not update the user highscroe' do
        user.process_quiz_score
        user.reload

        expect(user.highscore).to eq 100
      end
    end
  end
end
