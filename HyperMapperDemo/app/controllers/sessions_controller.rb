class SessionsController < ApplicationController
  
  def new
  end

  def create
  	user = User.authenticate(params[:session][:username], 
                             params[:session][:password])
  	if user
  	  sign_in(user)
  	  flash[:notice] = "Welcome, #{user.username}!"
  	  redirect_to user
  	else
  	  flash[:error] = "Invalid email/password combination"
  	  redirect_to new_session_path
  	end
  end

  def destroy
    flash[:notice] = "Logged out #{current_user.username}"
	  sign_out_user current_user
	  redirect_to users_path
  end

end