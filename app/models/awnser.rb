# frozen_string_literal: true

class Awnser < ApplicationRecord
  belongs_to :question

  validates :content, presence: true
  validates :content, uniqueness: { scope: :question, message: 'already exsits in question', case_sensitive: false }
end
