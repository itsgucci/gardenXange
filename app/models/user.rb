class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  has_one :user_profile
  has_many :gardens
  has_many :food_items,  :through => :gardens
  has_and_belongs_to_many :user_subscriptions 

  has_secure_password
  attr_accessor :email, :email_confirmation, :food_items

  validates :username, :presence => true, :uniqueness => true
  validates :email, :presence => true, :confirmation => true
  validates :password, :presence => { :on => :create }, 
            :confirmation => true

  after_create :create_garden

  public
  def set_food_items_by_id(food_items)
    food_items.each do |food_id|
      f = FoodItem.find_by_id(food_id)
      self.gardens.first.food_items << f
    end
  end
  def self.authenticate(username, password)                                                                                                                                                               
    user = User.find_by_username(username)
    unless user && user.authenticate(password)
      raise "Username or password invalid"
    end
    user
  end

  private
  def create_garden
    self.gardens << Garden.new
    save!
  end
end
