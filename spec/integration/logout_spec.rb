require 'spec_helper'

Capybara.default_wait_time = 5 
Capybara.ignore_hidden_elements = false
Capybara.current_driver = :webkit # for JS but cannot get page.execute_script to work with rspec

describe 'logout flow', :js => true do 
  before(:each) do                                                                                                                                                                                        
    @valid_attributes = {
      :username => "test_user_signup",
      :name => "Test User Signup",
      :email => "test_signup@test.com",
      :password => "some password"
    }
  end

  it 'should redirect to welcome page after clicking Logout' do
    User.create!(@valid_attributes)
    visit root_path

    click_link 'Login'
    page.find('div#login').should be_visible

    fill_in("Username", :with => @valid_attributes[:username])
    fill_in("Password", :with => @valid_attributes[:password])
    click_button 'Login'

    page.should have_content('Logout')
    page.should have_content('Show')
    page.find("[href='/logout']").should be_visible
    page.find('div#login').should_not be_visible

    click_link 'Logout'
    page.should have_content('Welcome')
    page.should have_content('Login')
    page.should_not have_content('Logout')
  end
end
