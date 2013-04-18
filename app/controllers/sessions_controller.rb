class SessionsController < ApplicationController
  #before_filter :new ladmbda { |ctlr| @title = "Sign in"}
  def new
  end

  def create
    user = User.authenticate(params[:email], params[:password])

    if user.nil?
      # sign in failure
      flash.now[:error] = "Invalid email/password combination."
      render :new
    else
      sign_in user
      redirect_to user
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end
end
