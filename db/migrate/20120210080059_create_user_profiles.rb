class CreateUserProfiles < ActiveRecord::Migration
  def change
    create_table :user_profiles do |t|
      t.string :address
      t.string :state
      t.string :city

      t.timestamps
    end
  end
end
