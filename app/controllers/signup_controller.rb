class SignupController < ApplicationController
  # GET /users
  # GET /users.json
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # Step 1: Choose your username
  # GET /signup/signup_user
  # GET /signup/signup_user.json
  def signup_user
    logger.info("In signup_user")
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # Step 1: Choose your username POST
  # This step saves this data only. Can return later.
  # POST /users
  # POST /users.json
  def create_user
    logger.info("In create_user action")
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to :action => 'select_edibles', id: @user.id, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        logger.error("User creation failed!")
        @modal_open = true
        format.html { render "signup_user" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # Step 2: Select Vegetables/Fruits you are growing GET
  # GET /signup/select_edibles
  # GET /signup/select_edibles.json
  def select_edibles
    @food_items = FoodItem.all                                 
    @user = User.find_by_id(params[:id]) #also handle could be nil

    respond_to do |format|
      @modal_open = true
      format.html { render "select_edibles" }
      format.json { render json: @food_items }
    end
  end

  # Step 2: Save Vegetables/Fruits you are growing POST
  # This step saves this data only. Can return later.
  # POST /save_edibles
  # POST /save_edibles.json
  def save_edibles
    @user = User.find_by_id(params[:user_id]) #also handle could be nil

    respond_to do |format|
      if @user.set_food_items_by_id(params[:food_items])
        format.html { redirect_to :action => 'select_edibles', id: @user.id, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        logger.error("User creation failed!")
        format.html { render action: "signup_user" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # Step 3: Subscribe to Vegetables/Fruits from other gardens GET
  #
  #

  # Step 3: Subscribe to Vegetables/Fruits from other gardens POST
  # This is the final step and should save ALL data.
  #

end
