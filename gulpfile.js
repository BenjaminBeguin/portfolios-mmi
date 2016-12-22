var gulp        = require('gulp');
var browserify  = require('browserify');
var source      = require('vinyl-source-stream');
var sass        = require('gulp-sass');
var sourcemaps  = require('gulp-sourcemaps');
var notify      = require('gulp-notify');
var browserSync = require('browser-sync').create();

// Config
var config = {
  allowNotifications: true,
	scripts: {
    entry: 'Main.es6',
    inputPath: './app/assets/javascripts',
		outputPath: './public/assets/js/'
	},
	styles: {
		entry: 'main.scss',
		inputPath: './app/assets/stylesheets',
		outputPath: './public/assets/css/'
	},
	browserSync: {
		proxy: "localhost:3000",
    port: 3001,
		open: false,
		notify: false,
		https: false,
		ui: false,
		ghostMode: false
	}
}

gulp.task('scripts', function () {
    var stream = browserify(config.scripts.inputPath + '/' + config.scripts.entry, {
      debug: true /* enables source maps */,
      extensions: ['.es6']
    }).bundle();

    return stream
      .pipe(source('main.js'))
      .pipe(gulp.dest(config.scripts.outputPath));
});

gulp.task('styles', function () {
	return gulp
		.src(config.styles.inputPath + '/' + config.styles.entry)
		.pipe(sass().on('error', function(err) {
			if (config.allowNotifications) {
				notify().write('Sass error : ' + err.message)
			} else {
				console.log(err)
			}

			this.emit('end');
		}))
    .pipe(sourcemaps.write())
		.pipe(gulp.dest(config.styles.outputPath))
		.pipe(browserSync.stream());
});

gulp.task('default', ['scripts', 'styles'], function () {
	browserSync.init(config.browserSync);

	// Watching for changes
	gulp.watch(config.styles.inputPath + '/**/*.scss', ['styles']);
	gulp.watch(config.scripts.inputPath + '/**/*.es6', ['scripts']);
});

gulp.task('build', ['scripts', 'styles']);
