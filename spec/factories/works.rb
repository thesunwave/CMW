FactoryGirl.define do
  factory :work do
    user_id       Faker::Number.number(4)
    image_file_id Faker::Number.number(4)
    title         Faker::Lorem.word
    views_count   Faker::Number.number(4)
    favs_count    Faker::Number.number(4)
    description   Faker::Lorem.paragraph(2)
    tags          Faker::Lorem.words().join(', ')
  end
end
