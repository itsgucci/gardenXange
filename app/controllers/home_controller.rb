class HomeController < ApplicationController
  # GET /show
  def show
    if user_authenticated?
      @user = User.find_by_id(session[:user_id])
      respond_to do |format|
        format.html { render :notice => "Welcome back #{@user.username}" } # show.html.erb
      end
    else
      respond_to do |format|
        format.html { redirect_to :action => :welcome }
      end
    end
  end

end
