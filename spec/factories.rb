Factory.define :user do |f|
  f.sequence(:username) { |n| "test#{n}" }
  f.password "test"
  f.password_confirmation { |u| u.password }
  f.sequence(:email) { |n| "test#{n}@example.com" }
end
