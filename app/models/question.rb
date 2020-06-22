# frozen_string_literal: true

class Question < ApplicationRecord
  has_many :awnsers, dependent: :destroy

  validates :content, :position, presence: true
  validates :position, uniqueness: true

  accepts_nested_attributes_for :awnsers, reject_if: :all_blank, allow_destroy: true

  def next_question
    Question.find_by(position: position + 1)
  end

  def next_question?
    Question.all.max_by(&:position) != self
  end

  def previous_question
    Question.find_by(position: position - 1)
  end

  def previous_question?
    Question.all.min_by(&:position) != self
  end
end
