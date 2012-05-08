require 'spec_helper'

describe "rendering the top bar" do
  it "should have Login and Signup links" do
    render :partial => 'shared/top_bar'
    rendered.should =~ /Login/
    rendered.should =~ /Signup/
  end

  it "should have Logout link and no Login or Signup links when logged in" do
    view.stub!(:session).and_return { {:user_id => '1'} }
    render :partial => 'shared/top_bar'
    rendered.should =~ /Logout/
    rendered.should_not =~ /Login/
    rendered.should_not =~ /Signup/
  end
  it "should have app name link" do
    render :partial => 'shared/top_bar'
    rendered.should =~ /gardenXange/
  end
end

