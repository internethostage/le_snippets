class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by_email params[:signin][:email]
    if @user && @user.authenticate(params[:signin][:password])
      session[:user_id] = @user.id
      redirect_to return_point, notice: "Logged in"
    else
      flash.now[:alert] = "Incorrect email or password"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    session[:return_point] = nil
    redirect_to root_path, notice: "Logged out!"
  end

end
