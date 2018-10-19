var gulp = require('gulp');
var browserSync = require('browser-sync').create();

var setupWatchers = function() {
  gulp.watch(['./app/views/**/*.haml',
    './app/assets/javascripts/**/*.js'], ['reload']);
  gulp.watch(['./app/assets/stylesheets/**/*.scss'], ['reloadCSS'])
};

gulp.task('reload', function(){
  return browserSync.reload();
});

gulp.task('reloadCSS', function() {
  return browserSync.reload('*.css');
});

gulp.task('init', function() {
  browserSync.init({
    proxy: 'localhost:3000',
    port: 8000,
    open: true,
    notify: true,
    snippetOptions: {
      rule: {
        match: /<\/head>/i,
        fn: function (snippet, match) {
          return snippet + match;
        }
      }
    },
    ui: {
      port: 8001
    }
  });

  setupWatchers();
});

gulp.task('default', ['init']);
