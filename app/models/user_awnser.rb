# frozen_string_literal: true

class UserAwnser < ActiveRecord::Base
  belongs_to :user
  belongs_to :awnser
end
