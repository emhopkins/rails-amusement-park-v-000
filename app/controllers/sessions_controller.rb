class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    # raise params.inspect
    user = User.find_by(name: session_params[:name])
    return head(:forbidden) unless user.authenticate(session_params[:password])
    session[:user_id] = user.id
    redirect_to user_path(user)
  end

  def destroy
	 session.delete :user_id
	 redirect_to root_url
  end

  private

  def session_params
    params.require(:user).permit(:name, :password)
  end

end
