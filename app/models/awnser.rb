# frozen_string_literal: true

class Awnser < ApplicationRecord
  belongs_to :question
  has_many :user_awnsers
  has_many :users, through: :user_awnsers

  validates :content, presence: true
  validates :content, uniqueness: { scope: :question, message: 'already exsits in question', case_sensitive: false }
end
