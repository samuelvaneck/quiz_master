# frozen_string_literal: true

class Question < ApplicationRecord
  has_many :awnsers

  validates :content, :position, presence: true
  validates :position, uniqueness: true

  accepts_nested_attributes_for :awnsers
end
