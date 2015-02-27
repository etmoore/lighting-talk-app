class AuthenticationsController < ApplicationController
  def create
    username = request.env['omniauth.auth']['info']['nickname']
    github_id = request.env['omniauth.auth']['uid']
    email = request.env['omniauth.auth']['info']['email']
    auth_token = request.env['omniauth.auth']['credentials']['token']
    user = User.find_or_create_by(email: email, auth_token: auth_token, username: username)

    if user.present?
      session[:access_token] = auth_token
      redirect_to root_path, notice: "Thanks for signing in #{user.username}"
    else
      redirect_to root_path, notice: "Something went wrong"
    end
  end

  def destroy
    session.clear
    flash[:notice] = "Logged out!"
    redirect_to root_path
  end
end
