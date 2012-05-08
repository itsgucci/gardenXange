require File.dirname(__FILE__) + '/../spec_helper'

describe FoodItemsController, "food items" do
  render_views

  it "should return a list of food items for GET :index with json format " do
    get :index, :format => :json
    response.header['Content-Type'].should include 'application/json'
    response.body.should_not be_nil
  end
end
