# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

users = User.create([{id: '1', email: 'admin@admin.com', encrypted_password: '111111111',
                  lang: 'ru', description: 'Лучший в мире человек', website: 'http://localhost',
                  vk: 'http://vk.com/id5692307', username: 'thesunwave',
                  first_name: 'Albert', last_name: 'Lanning', spec: 'Лютый дизайнер'}])

quote = Quote.create([ { text_rus: "Самый лучший день, заходил вчера", text_eng: "The best day was came yesterday." ,
                                  author_rus: "Григорий Лепс", author_eng: "Leps Grigory" },
                                { text_rus: "Этот парень был из тех, кто просто любит жить", text_eng: "This guy was one of those who just loves life" ,
                                  author_rus: "Кипелов", author_eng: "Kipelov" }])