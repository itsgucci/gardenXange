require File.dirname(__FILE__) + '/../spec_helper'

describe SessionsController, "session management" do
  render_views

  it "should redirect to intended action on successful login" do
    user = FactoryGirl.create(:user, :username => 'frank', :password => 'secret')
    session[:intended_action] = 'index'
    session[:intended_controller] = 'articles'
    post 'create', :username => 'frank', :password => 'secret'
    flash[:notice].should_not be_nil
    response.should redirect_to(:action => session[:intended_action],
                                :controller => session[:intended_controller])
  end

  it "should not redirect to intended action on failed login" do
    user = FactoryGirl.create(:user, :username => 'frank', :password => 'secret')
    session[:intended_action] = 'index'
    session[:intended_controller] = 'articles'
    begin
      post 'create', :username => 'frank', :password => 'wrong'
    rescue Exception => e
      e.message.should_not be_nil
    end
    flash[:notice].should be_nil
    response.should_not redirect_to(:action => session[:intended_action],
                                    :controller => session[:intended_controller])
  end
    
end
