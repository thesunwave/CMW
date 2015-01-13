FactoryGirl.define do
  factory :notification_types_role do
    notification_type_id Faker::Number.digit
	role_id              Faker::Number.digit
  end

end
