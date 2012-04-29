require File.dirname(__FILE__) + '/../spec_helper'

describe HomeController, "home page for all users" do
  render_views

  it "home#show should redirect to home#welcome when not authenticated" do
    get 'show'
    response.should redirect_to(:action => 'welcome',
                                :controller => 'home')
  end
end
