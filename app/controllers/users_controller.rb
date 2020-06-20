# frozen_string_literal: true

class UsersController < ApplicationController
  def new
    @user = User.new
  end

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
