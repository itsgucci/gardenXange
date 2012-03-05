class CreateGardensFoodItemsJoinTable < ActiveRecord::Migration
  def change
    create_table :gardens_food_items, :id => false do |t|
      t.integer :garden_id
      t.integer :food_item_id
    end
  end
end
