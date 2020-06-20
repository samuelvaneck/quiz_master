# frozen_string_literal: true

require 'rails_helper'

class UsersController < ApplicationController
  def create
    @user = User.create user_params
    respond_with @user
  end

  def show
    @user = User.find params[:id]
    respond_with @user
  end

  private

  def user_params
    params.require(:user).permit(:name)
  end
end
