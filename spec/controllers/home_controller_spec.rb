require File.dirname(__FILE__) + '/../spec_helper'

describe HomeController, "home page for all users" do
  render_views

  it "home#show should render to home#welcome when not authenticated" do
    get 'show'
    response.should render_template(:welcome)
  end
end
