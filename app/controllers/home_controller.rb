class HomeController < ApplicationController
  # GET /show
  def show
    @user_count = User.count
    if user_authenticated? and User.find_by_id(session[:user_id])
      @user = User.find_by_id(session[:user_id])
      respond_to do |format|
        format.html { render :notice => "Welcome back #{@user.username}" } # show.html.erb
      end
    else
      @user = User.new
      respond_to do |format|
        format.html { render :action => :welcome }
      end
    end
  end

  # UI Mockups for user testing
  # GET /mocks (see routes) for alpha
  def mocks
      session[:user_id] = 1
      @user = User.find_by_id(session[:user_id])
      respond_to do |format|
        format.html { render :action => :mocks, :layout => "appmocks"}
      end
  end
end
