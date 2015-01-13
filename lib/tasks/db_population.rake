namespace :db do
  desc "Fill database with fake mixes"
  task populate: :environment do    
    sound = [12, 13, 15]
    image = [11, 12, 14]
    dur = [2872, 3906, 5022]
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
      Mix.create!(user_id: user.id,
                  sound_file_id: sound[file],
                  image_file_id: image[r.rand(2)],
                  title: "Fake gen mix" + n.to_s,
                  status: 5,
                  desc: "Fake mix description" + n.to_s,
                  duration: dur[file])
    end
  end
end