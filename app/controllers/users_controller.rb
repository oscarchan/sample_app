class UsersController < ApplicationController
  def new
    @user = User.new
    @title = "Sign up"
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      #
    else
      @title = "Sign Up"
      render 'new'
    end
  end
end
