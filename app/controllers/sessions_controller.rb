class SessionsController < ApplicationController
  #before_filter :new ladmbda { |ctlr| @title = "Sign in"}
  def new
  end

  def create
    user = User.authenticate(params[:email], params[:password])

    if user
      sign_in user
      redirect_back_or user
    else
      # sign in failure
      flash.now[:error] = "Invalid email/password combination."
      render :new
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end
end
