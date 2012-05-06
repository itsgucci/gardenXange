require File.dirname(__FILE__) + '/../spec_helper'

describe HomeController, "home page for all users" do
  render_views

  it "home#show should redirect to home#welcome when not authenticated" do
    get 'show'
    response.should render_template(:welcome)
  end

  it "home#welcome should show a signup and login link" do
    get 'show'
    assert_select "[href='#signup']"
    assert_select "[href='#login']"
  end

end
