FactoryGirl.define do
  factory :image_file do
    image_file_name    Faker::Avatar.image
    image_content_type 'image/jpeg'
    image_file_size    Faker::Number.number(4)
    image_updated_at   Time.now
  end
end
