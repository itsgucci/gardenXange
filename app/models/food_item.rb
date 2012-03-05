class FoodItem < ActiveRecord::Base
  has_and_belongs_to_many :gardens
  has_many :users, :through => :gardens

  def self.search_by_prefix (prefix)
    self.where("lower(name) LIKE '#{prefix.downcase}%'")
  end
end
