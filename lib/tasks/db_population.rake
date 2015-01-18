namespace :db do
  desc "Fill database with fake works"
  task populate: :environment do    
    image = [11, 12, 14]
    r = Random.new
    99.times do |n|
      user = User.create!(email: Faker::Internet.email,
                         password: '123456',
                         username: Faker::Internet.user_name,
                         first_name: Faker::Name.first_name,
                         last_name: Faker::Name.last_name,
                         lang: 'ru',
                         confirmed_at: Time.now)
      file = r.rand(2)
      Work.create!(user_id: user.id,
                  image_file_id: image[r.rand(2)],
                  title: "Fake gen work" + n.to_s,
                  desc: "Fake work description" + n.to_s,
    end
  end
end