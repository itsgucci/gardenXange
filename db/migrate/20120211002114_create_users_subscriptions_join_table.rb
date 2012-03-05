class CreateUsersSubscriptionsJoinTable < ActiveRecord::Migration
  def change
    create_table :users_subscriptions, :id => false do |t|
      t.integer :user_id
      t.integer :subscription_id
    end
  end
end
