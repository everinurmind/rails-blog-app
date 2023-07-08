require_relative '../models/user'

class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.includes(posts: [:comments]).find(params[:id])
  end

  def create
    @user = User.new(user_params)
    @user.photo = params[:user][:photo] if params[:user][:photo].present?
  
    if @user.save
      redirect_to user_path(@user), notice: 'User created successfully.'
    else
      render :new, alert: 'Failed to create user.'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path, notice: 'User successfully deleted.'
  end
end
