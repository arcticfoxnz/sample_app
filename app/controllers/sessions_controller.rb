class SessionsController < ApplicationController
  before_filter :what_user, only: [:create, :new]

  def new
  end
  
  def create
    user = User.find_by_email(params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_back_or user
    else
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end

  private
  
#  def what_user
#      redirect_to root_url unless @current_user == nil
#  end
  
  def what_user
    if signed_in?
      redirect_to(root_path)
    end
  end
end
