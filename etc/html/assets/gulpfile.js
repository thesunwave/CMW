var gulp       = require('gulp'),            // Gulp JS
	compass    = require('gulp-compass'),    // Плагин для Compass
	coffee     = require('gulp-coffee'),     // Плагин для Coffeescript
	csso       = require('gulp-csso'),       // Минификация CSS
	imagemin   = require('gulp-imagemin'),   // Минификация изображений
	uglify     = require('gulp-uglify'),     // Минификация JS
	htmlmin    = require('gulp-htmlmin'),    // Минификация html
	concat     = require('gulp-concat'),     // Склейка файлов
	rename     = require('gulp-rename');     // Переименование файлов

var javascripts = [ // Объявляем порядок сборки пользовательских скриптов
	'./javascripts/zoQ_components/zoQ_components.coffee',
	'./javascripts/zoQ_components/components/common.coffee',
	'./javascripts/zoQ_components/components/ajax_component.coffee',
	'./javascripts/zoQ_components/components/alerts_component.coffee',
	'./javascripts/zoQ_components/components/popups_component.coffee',
	'./javascripts/zoQ_components/components/core.coffee',
	'./javascripts/zoQ_components/initializer.coffee'
];

var vendor = [ // Объявляем порядок сборки вендорных скриптов
	'./javascripts/vendor/jquery-2.1.1.js',
	'./javascripts/vendor/fastclick-1.0.3.js',
	'./javascripts/vendor/head.load-1.0.3.js'
];

var php = false;

// Собираем стили
gulp.task('compass', function() {
	gulp.src('./stylesheets/application.sass')
		.pipe(compass({
			config_file : 'config.rb',
			css         : '../public/stylesheets/',
			sass        : __dirname + '/stylesheets/'
		}))
		.on('error', console.log);
});

// Собираем Html
gulp.task('html', function() {
	if (php) {
		gulp.src('./template/**/*')
			.pipe(rename({extname: '.php'}))
			.pipe(gulp.dest('../public/')); // Записываем собранные файлы
	} else {
		gulp.src('./template/**/*')
			.pipe(gulp.dest('../public/')); // Записываем собранные файлы
	}
}); 

// Собираем скрипты
gulp.task('coffee', function() {
	gulp.src(javascripts)
		.pipe(coffee())
		.pipe(concat('zoQ_components-2.0.2.js'))                 // Собираем скрипты
		.on('error', console.log)
		.pipe(gulp.dest('../public/javascripts/vendor/')); // Записываем скрипты
});

// Собираем пользовательские скрипты
gulp.task('userScripts', function() {
	gulp.src('./javascripts/public/application.coffee')
		.pipe(coffee())
		.pipe(concat('application.js'))             // Собираем скрипты
		.on('error', console.log)
		.pipe(gulp.dest('../public/javascripts/')); // Записываем скрипты

	gulp.src('./javascripts/public/all.coffee')
		.pipe(coffee())
		.pipe(concat('all.js'))                     // Собираем скрипты
		.on('error', console.log)
		.pipe(gulp.dest('../public/javascripts/')); // Записываем скрипты
});

// Собираем вендорные скрипты
gulp.task('vendor', function() {
	gulp.src(vendor)
		.on('error', console.log)
		.pipe(gulp.dest('../public/javascripts/vendor')); // Записываем скрипты
});

// Копируем и минимизируем изображения
gulp.task('images', function() {
	gulp.src('./images/**/*')
		.pipe(gulp.dest('../public/images'));  // Записываем изображения

	gulp.src('./uploads/**/*')
		.pipe(gulp.dest('../public/uploads')); // Записываем изображения
});

// Запуск сервера разработки gulp watch
gulp.task('watch', function() {
	// Предварительная сборка проекта
	gulp.start('compass', 'html', 'images', 'coffee', 'userScripts','vendor');

	gulp.watch('stylesheets/**/*.sass', function() {
		gulp.start('compass');
	});
	gulp.watch('template/**/*.html', function() {
		gulp.start('html');
	});
	gulp.watch('images/**/*', function() {
		gulp.start('images');
	});
	gulp.watch('javascripts/**/*', function() {
		gulp.start('coffee');
		gulp.start('userScripts');
	});
});

// Сборка проекта
gulp.task('build', function() {
	// Собираем стили
	gulp.src('../public/stylesheets/application.css')
		.pipe(csso())                              // Сжимаем стили
		.pipe(gulp.dest('../build/stylesheets/'));

	// Собираем html
	if (php) {
		gulp.src('./template/**/*')
			.pipe(htmlmin({collapseWhitespace: true, minifyJS: true})) // Минифицируем html
			.pipe(rename({extname: '.php'}))
			.pipe(gulp.dest('../build/'));                             // Записываем собранные файлы
	} else {
		gulp.src('./template/**/*')
			.pipe(htmlmin({collapseWhitespace: true, minifyJS: true})) // Минифицируем html
			.pipe(gulp.dest('../build/'));                             // Записываем собранные файлы
	}

	// Собираем скрипты
	gulp.src('../public/javascripts/**/*.js')
		.pipe(uglify())                            // Сжимаем скрипты
		.pipe(gulp.dest('../build/javascripts/')); // Записываем скрипты

	// Копируем и минимизируем изображения
	gulp.src('./images/**/*')
		.pipe(imagemin())                    // Сжимаем изображения
		.pipe(gulp.dest('../build/images')); // Записываем изображения

	gulp.src('./uploads/**/*')
		.pipe(imagemin())                     // Сжимаем изображения
		.pipe(gulp.dest('../build/uploads')); // Записываем изображения
});
