require 'spec_helper'

Capybara.default_wait_time = 5 
Capybara.ignore_hidden_elements = false
Capybara.current_driver = :webkit # for JS but cannot get page.execute_script to work with rspec

describe 'signup flow', :js => true do 
  before(:each) do                                                                                                                                                                                        
    @valid_attributes = {
      :username => "test_user_signup",
      :name => "Test User Signup",
      :email => "test_signup@test.com",
      :password => "some password"
    }
  end

  it 'should open signup modal on Welcome page after clicking Signup' do
    visit root_path
    page.should have_content('Signup')
    page.should have_content('Welcome')
    page.find('.navbar').find("[href='#signup']").should be_visible
    page.find('.hero-unit').find("[href='#signup']").should be_visible
    page.find('.navbar').find("[href='#login']").should be_visible
    page.find('.navbar').find("[href='#login']").should be_visible
    #save_and_open_page
    #print page.html
    #p page.find('div#signup')['class']
    #p page.find('div#signup').visible?
    #p page.execute_script("$('div#signup').css('display');")
    #p page.find('div#signup').methods.sort
    page.find('div#signup').should_not be_visible
    click_link 'Signup'
    page.should have_css('div#signup.modal', :visible => false)
    page.find('div#signup').should be_visible
  end

  it "should close signup modal after clicking x button" do
    visit root_path
    page.should have_content('Signup')
    page.should have_content('Welcome')
    page.find("[href='#signup']").should be_visible
    page.find("[href='#login']").should be_visible
    page.find('div#signup').should_not be_visible
    click_link 'Signup'
    page.find('div#signup').should be_visible
    click_link 'x' # not firing click on button in selenium
    page.find('div#signup').should_not be_visible
    page.should have_content('Welcome')
  end

  it "should close signup modal after clicking Cancel link" do
    visit root_path
    page.should have_content('Signup')
    page.should have_content('Welcome')
    page.find("[href='#signup']").should be_visible
    page.find("[href='#login']").should be_visible
    page.find('div#signup').should_not be_visible
    click_link 'Signup'
    page.find('div#signup').should be_visible
    click_link 'Cancel'
    page.find('div#signup').should_not be_visible
    page.should have_content('Welcome')
  end

  it "should render signup modal with errors after submit for duplicate username" do
    User.create!(@valid_attributes)
    visit root_path
    click_link 'Signup'
    page.find('div#signup').should be_visible
    page.should have_content('Step 1')

    fill_in("Username", :with => @valid_attributes[:username])
    fill_in("Password", :with => @valid_attributes[:password])
    fill_in("Password confirmation", :with => @valid_attributes[:password])
    fill_in("Email", :with => @valid_attributes[:email])
    fill_in("Email confirmation", :with => @valid_attributes[:email])
    click_button 'Next'

    page.find('div#signup').should be_visible
    page.should have_content('Step 1')
    page.should_not have_content('Step 2')
    page.find('div#error_explanation').should be_visible
    page.should have_content('prohibited this user from being saved')
    page.should have_content('Username has already been taken')
  end

  it "should render select_edibles modal after submit for valid new user data" do
    visit root_path
    click_link 'Signup'
    page.find('div#signup').should be_visible
    page.should have_content('Step 1')

    fill_in("Username", :with => @valid_attributes[:username])
    fill_in("Password", :with => @valid_attributes[:password])
    fill_in("Password confirmation", :with => @valid_attributes[:password])
    fill_in("Email", :with => @valid_attributes[:email])
    fill_in("Email confirmation", :with => @valid_attributes[:email])
    click_button 'Next'

    page.find('div#signup').should be_visible
    page.should have_content('Step 2')
  end

  it "should be authenticated after creating an account via signup modal" do
    visit root_path
    click_link 'Signup'
    page.find('div#signup').should be_visible
    page.should have_content('Step 1')

    fill_in("Username", :with => @valid_attributes[:username])
    fill_in("Password", :with => @valid_attributes[:password])
    fill_in("Password confirmation", :with => @valid_attributes[:password])
    fill_in("Email", :with => @valid_attributes[:email])
    fill_in("Email confirmation", :with => @valid_attributes[:email])
    click_button 'Next'
    click_link 'Cancel'

    page.should have_content('Show')
  end

  it "should close select_edibles modal after clicking x link" do
  end

  it "should close select_edibles modal after clicking Cancel link" do
    visit root_path
    click_link 'Signup'
    page.find('div#signup').should be_visible
    page.should have_content('Step 1')

    fill_in("Username", :with => @valid_attributes[:username])
    fill_in("Password", :with => @valid_attributes[:password])
    fill_in("Password confirmation", :with => @valid_attributes[:password])
    fill_in("Email", :with => @valid_attributes[:email])
    fill_in("Email confirmation", :with => @valid_attributes[:email])
    click_button 'Next'

    page.find('div#signup').should be_visible
    page.should have_content('Step 2')
    click_link 'Cancel'
    page.find('div#signup').should_not be_visible
    page.should have_content('Show')
  end

  # Consider moving this to a login integration test
  it "should not display signup and login link if authenticated, and logout present" do
    User.create!(@valid_attributes)
    visit root_path
    click_link 'Login'
    page.find('div#login').should be_visible

    fill_in("Username", :with => @valid_attributes[:username])
    fill_in("Password", :with => @valid_attributes[:password])
    click_button 'Login'

    page.find('div#login').should_not be_visible
    page.should have_content('Welcome back')
    page.should_not have_content('Signup')
    page.find("[href='#{logout_path}']").should be_visible
    page.should have_no_selector("[href='#login']")
    page.should have_no_selector("[href='#signup']")
  end

end
