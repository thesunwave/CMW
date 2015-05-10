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

quote = Quote.create([ 
	{
		text_rus: "Дизайн спасёт мир.", text_eng: "",
		author_rus: "Артемий Лебедев", author_eng: ""
	},
	{
		text_rus: "Дизайн — это не то, как предмет выглядит, а то, как он работает.", text_eng: "",
		author_rus: "Стив Джобс", author_eng: ""
	},
	{
		text_rus: "Дизайнер живёт своей профессией, делая из хаоса порядок.", text_eng: "",
		author_rus: "Артемий Лебедев", author_eng: ""
	},
	{
		text_rus: "Хороший дизайн виден сразу. Отличный дизайн незаметен.", text_eng: "",
		author_rus: "Джо Спарано", author_eng: ""
	},
	{
		text_rus: "Если вы хотите быть дизайнером, вы должны сделать выбор: либо принимать разумные решения, либо зарабатывать деньги.", text_eng: "",
		author_rus: "Ричард Фуллер", author_eng: ""
	},
	{
		text_rus: "Бог — такой же художник, как другие художники.", text_eng: "",
		author_rus: "Пабло Пикассо", author_eng: ""
	},
	{
		text_rus: "Дизайнер должен быть интерпретатором и реальных, и виртуальных потребностей, должен предугадывать те запросы людей, о которых они не задумываются и неожиданно открывают в уже созданных предметах.", text_eng: "",
		author_rus: "Акилле Кастильони", author_eng: ""
	},
	{
		text_rus: "<nobr>Ирония должна присутствовать и в дизайне, и в предметах. Я замечаю в окружающих меня людях профессиональную болезнь:</nobr> всё воспринимается слишком серьезно. Один из моих секретов в том, что я постоянно шучу.", text_eng: "",
		author_rus: "Акилле Кастильони", author_eng: ""
	},
	{
		text_rus: "Дизайнеры — счастливые люди. Мы создаем свои объекты не ради славы, а потому что относимся к жизни с огромным любопытством.", text_eng: "",
		author_rus: "Паола Навоне", author_eng: ""
	},
	{
		text_rus: "Дизайн — занятие для одержимых. Все дизайнеры, которых я знаю, слегка одержимые...", text_eng: "",
		author_rus: "Майкл Янг", author_eng: ""
	},
	{
		text_rus: "Хорошие дизайнеры редко становятся хорошими рекламистами, поскольку они увлекаются внешней красотой и забывают о продаже продукта.", text_eng: "",
		author_rus: "Джеймс Адамс", author_eng: ""
	},
	{
		text_rus: "<nobr>Невозможно создать хороший продукт, основываясь на опросах людей или пользуясь фокус-группами.</nobr> Люди сами не знают чего они хотят, пока им это не покажешь.", text_eng: "",
		author_rus: "Стив Джобс", author_eng: ""
	}
	
])