# frozen_string_literal: true

class Question < ApplicationRecord
  validates :content, :position, presence: true
  validates :position, uniqueness: true
end
