
FactoryGirl.define do
  
  factory :work do
    title 'Work1'
    desc 'Some work'
    image_file ImageFile.new
  end
end
