class User < ApplicationRecord
  has_many :user_awnsers
  has_many :awnsers, through: :user_awnsers
end
