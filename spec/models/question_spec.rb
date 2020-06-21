# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Question, type: :model do
  let(:question_one) { FactoryBot.create :question, position: 0 }
  let(:question_two) { FactoryBot.create :question, position: 1 }
  let(:question_three) { FactoryBot.create :question, position: 2 }
  let(:question_four) { FactoryBot.create :question, position: 3 }
  let(:question_five) { FactoryBot.create :question, position: 4 }

  before do
    question_one
    question_two
    question_three
    question_four
    question_five
  end

  describe '#next_question' do
    context 'with a next question present' do
      it 'returns the next question' do
        expect(question_one.next_question).to eq question_two
      end
    end

    context 'with no next question present' do
      it 'returns nil' do
        expect(question_five.next_question).to eq nil
      end
    end
  end

  describe '#next_question?' do
    context 'with a next question present' do
      it 'returns true' do
        expect(question_two.next_question?).to eq true
      end
    end

    context 'with no next question present' do
      it 'returns false' do
        expect(question_five.next_question?).to eq false
      end
    end
  end

  describe '#previous_question' do
    context 'with a previous question present' do
      it 'returns the previous question' do
        expect(question_four.previous_question).to eq question_three
      end
    end

    context 'with no previous question present' do
      it 'returns nil' do
        expect(question_one.previous_question).to eq nil
      end
    end
  end

  describe '#previous_question?' do
    context 'with a previous question present' do
      it 'returns true' do
        expect(question_two.previous_question?).to eq true
      end
    end

    context 'with no previous question present' do
      it 'returns false' do
        expect(question_one.previous_question?).to eq false
      end
    end
  end
end
