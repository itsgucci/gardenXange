class Garden < ActiveRecord::Base
  has_one :user
  has_and_belongs_to_many :food_itmes
end
