require 'spec_helper'

Capybara.default_wait_time = 5 
Capybara.ignore_hidden_elements = false
Capybara.current_driver = :webkit # for JS but cannot get page.execute_script to work with rspec

describe 'signup flow', :js => true do 

  it 'should open signup modal on Welcome page after clicking Signup' do
    visit root_path
    page.should have_content('Signup')
    page.should have_content('Welcome')
    page.find("[href='#signup']").should be_visible
    page.find("[href='#login']").should be_visible
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
    click_button 'x'
    page.find('div#signup').should_not be_visible
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
  end

  it "should render signup modal with errors after after submit for duplicate username" do
  end

  it "should render select_edibles modal after submit for valid new user data" do
  end

  it "should close select_edibles modal after clicking x link" do
  end

  it "should close select_edibles modal after clicking Close link" do
  end

  it "should not display signup and login link if authenticated, and logout present" do
  end

end
