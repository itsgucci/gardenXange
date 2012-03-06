class Garden < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :food_items, :join_table => :gardens_food_items
end
