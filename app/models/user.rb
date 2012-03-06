class User < ActiveRecord::Base
  has_one :user_profile
  has_many :gardens
  has_many :food_items,  :through => :gardens
  has_and_belongs_to_many :user_subscriptions 

  attr_accessor :email, :email_confirmation, :password, :password_confirmation, :food_items

  validates :username, :presence => true, :uniqueness => true
  validates :email, :presence => true, :confirmation => true
  validates :password, :presence => true, :confirmation => true

  after_create :create_garden

  public
  def set_food_items_by_id(food_items)
    food_items.each do |food_id|
      f = FoodItem.find_by_id(food_id)
      self.gardens.first.food_items << f
    end
  end

  private
  def create_garden
    self.gardens << Garden.new
    save!
  end
end
