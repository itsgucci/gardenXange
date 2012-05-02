class SessionsController < ApplicationController
  
  def create 
    logger.info("CREATING SESSION")
    session[:user_id] = User.authenticate(params[:username], params[:password]).id 
    @user = User.find_by_id(session[:user_id])
    flash[:notice] = "Welcome back #{@user.username}!" 
    logger.info(session[:intended_action])
    logger.info(session[:intended_controller])
    if ! session[:intended_action] or session[:intended_action] == 'welcome'
      session[:intended_controller] = 'home'
      session[:intended_action] = 'show'
    end
    redirect_to :action => session[:intended_action],
                :controller => session[:intended_controller]
  end

  def destroy 
    session[:user_id] = nil 
    redirect_to root_url, :notice => "Come back soon!"
  end
end
