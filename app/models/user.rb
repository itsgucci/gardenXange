class User < ActiveRecord::Base
  has_one :user_profile
  has_many :food_items,  :through => :garden
  has_and_belongs_to_many :user_subscriptions 

  attr_accessor :email, :email_confirmation, :password, :password_confirmation

  validates :username, :presence => true, :uniqueness => true
  validates :email, :presence => true, :confirmation => true
  validates :password, :presence => true, :confirmation => true

end
