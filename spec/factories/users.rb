# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    first_name 'Example'
    last_name 'User'
    email
    password 'somepass'
    password_confirmation 'somepass'
    # required if the Devise Confirmable module is used
    confirmed_at Time.now
    lang 'ru'
  end

  factory :user_minimal_attrs do
    email
    password 'somepass'
    password_confirmation 'somepass'
    lang 'ru'
  end

  sequence :email do |n|
    "person#{n}@example.com"
  end
end
