# frozen_string_literal: true

class User < ApplicationRecord
  has_many :user_awnsers
  has_many :awnsers, through: :user_awnsers

  validates :name, presence: true

  def quiz_score
    return 0 if awnsers.blank?

    awnsers.map(&:score).reduce(:+)
  end

  def process_awnser(awnser)
    question_awnsers = awnser.question.awnsers
    # remove any previous awnsers
    question_awnsers.each do |question_awnser|
      awnsers.delete(question_awnser) if awnser_ids.include? question_awnser.id
    end
    # add the new awnser
    awnsers << awnser
  end

  def quiz_reset
    awnsers.clear
  end

  def process_quiz_score
    return false if quiz_score <= highscore

    update(highscore: quiz_score)
  end
end
