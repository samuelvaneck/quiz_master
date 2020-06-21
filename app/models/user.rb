class User < ApplicationRecord
  has_many :user_awnsers
  has_many :awnsers, through: :user_awnsers

  validates :name, presence: true

  def quiz_score
    awnsers.map(&:score).reduce(:+)
  end
end
