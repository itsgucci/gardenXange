require 'spec_helper'

Capybara.default_wait_time = 5 
Capybara.ignore_hidden_elements = false
Capybara.current_driver = :webkit # for JS but cannot get page.execute_script to work with rspec

describe 'login flow', :js => true do 
  before(:each) do                                                                                                                                                                                        
    @valid_attributes = {
      :username => "test_user_signup",
      :name => "Test User Signup",
      :email => "test_signup@test.com",
      :password => "some password"
    }
  end

  it 'should open login modal on Welcome page after clicking Login' do
    visit root_path
    page.should have_content('Login')
    page.should have_content('Welcome')
    page.find("[href='#login']").should be_visible
    page.find('div#login').should_not be_visible
    click_link 'Login'
    page.find('div#login').should be_visible
  end

  it "should close login modal after clicking x button" do
    visit root_path
    page.should have_content('Login')
    page.should have_content('Welcome')
    page.find("[href='#login']").should be_visible
    page.find('div#login').should_not be_visible
    click_link 'Login'
    page.find('div#login').should be_visible
    save_and_open_page
    print page.html
    click_link 'x' # not firing click on button in selenium
    page.find('div#login').should_not be_visible
    page.should have_content('Welcome')
  end

  it "should close login modal after clicking Cancel link" do
    visit root_path
    page.should have_content('Login')
    page.should have_content('Welcome')
    page.find("[href='#login']").should be_visible
    page.find('div#login').should_not be_visible
    click_link 'Login'
    page.find('div#login').should be_visible
    click_link 'Close'
    page.find('div#login').should_not be_visible
    page.should have_content('Welcome')
  end

  it "should render login modal with errors after submit for wrong password" do
    User.create!(@valid_attributes)
    visit root_path
    click_link 'Login'
    page.find('div#login').should be_visible

    fill_in("Username", :with => @valid_attributes[:username])
    fill_in("Password", :with => 'wrong')
    click_button 'Login'

    page.find('div#login').should be_visible
    page.find('div#error_explanation').should be_visible
    page.should have_content('Username or password invalid')
  end

  it "should render login modal with errors after submit for wrong username" do
    User.create!(@valid_attributes)
    visit root_path
    click_link 'Login'
    page.find('div#login').should be_visible

    fill_in("Username", :with => 'wrong username')
    fill_in("Password", :with => @valid_attributes[:password])
    click_button 'Login'

    page.find('div#login').should be_visible
    page.find('div#error_explanation').should be_visible
    page.should have_content('Username or password invalid')
  end

  it "should render login modal with errors after submit for empty username, password" do
    User.create!(@valid_attributes)
    visit root_path
    click_link 'Login'
    page.find('div#login').should be_visible

    click_button 'Login'

    page.find('div#login').should be_visible
    page.find('div#error_explanation').should be_visible
    page.should have_content('Username or password invalid')
  end

  it "should be authenticated after entering correct username, password" do
    User.create!(@valid_attributes)
    visit root_path
    click_link 'Login'
    page.find('div#login').should be_visible

    fill_in("Username", :with => @valid_attributes[:username])
    fill_in("Password", :with => @valid_attributes[:password])
    click_button 'Login'

    page.should have_content('Show')
    page.should have_content("Welcome back #{@valid_attributes[:username]}")
    page.should have_content('Logout')
    page.should have_no_selector("[href='#login']")
    page.should have_no_selector("[href='#signup']")
  end
end
