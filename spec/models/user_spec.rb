require 'spec_helper'

describe User do
  before(:each) do
    @valid_attributes = {
      :username => "test_user",
      :name => "Test User",
      :email => "test@test.com",
      :password => "some password"
    }
  end

  it "creates a new instance given valid attributes" do
    User.create!(@valid_attributes)
  end

  it "doesn't create a new instance if username not unique" do
    User.create!(@valid_attributes)
    lambda {
      User.create(@valid_attributes)
    }.should change(User, :count).by(0)
  end

  it "initially has no food items" do
    u = User.create!(@valid_attributes)
    u.food_items.should be_nil
  end

  it "creates a new garden after user created" do
    u = User.create!(@valid_attributes)
    u.gardens.should_not be_nil
  end

  it "should authenticate with correct username, password" do
    user = FactoryGirl.create(:user, :username => 'frank', :password => 'secret')
    User.authenticate('frank', 'secret').should == user
  end

  it "should not authenticate with incorrect password" do
    user = FactoryGirl.create(:user, :username => 'frank', :password => 'secret')
    begin
      User.authenticate('frank', 'wrong').should be_nil
    rescue Exception => e
      e.message.should_not be_nil
    end
  end

  it "should not authenticate with incorrect username" do
    user = FactoryGirl.create(:user, :username => 'frank', :password => 'secret')
    begin
      User.authenticate('wrong', 'secret').should be_nil
    rescue Exception => e
      e.message.should_not be_nil
    end
  end
 
end
