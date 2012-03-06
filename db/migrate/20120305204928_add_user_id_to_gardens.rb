class AddUserIdToGardens < ActiveRecord::Migration
 change_table :gardens do |t|
    t.references :user
  end
end
