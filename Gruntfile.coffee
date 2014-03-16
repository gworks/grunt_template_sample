module.exports = (grunt) ->
  grunt.initConfig
    pkg_name: "grunt_template"
    dest_dir: ""
    src_dir: "src/"

    concat:
      js_files:
        src: [
          "<%= src_dir %>js/*.js"
        ]
        dest: "<%= dest_dir %>js/<%= pkg_name %>.js"
      css_files:
        src: [
          "<%= src_dir %>css/*.css"
        ]
        dest: "<%= dest_dir %>css/<%= pkg_name %>.css"

    htmlmin:
      dist:
        options:
          removeComments: true
          collapseWhitespace: true
        files:
          "<%= dest_dir %>index.html" : "<%= src_dir %>index.html"
          "<%= dest_dir %>child/sample.html" : "<%= src_dir %>child/sample.html"

    jshint:
      beforeconcat: "<%= src_dir %>js/**/*_userscript.js"

    uglify:
      options:
        banner: "/* <%= pkg_name %> <%= grunt.template.today('yyyy-mm-dd') %> */\n"
      build:
        src: "<%= dest_dir %>js/<%= pkg_name %>.js"
        dest: "<%= dest_dir %>js/<%= pkg_name %>.min.js"

    cssmin:
      dist:
        src: "<%= dest_dir %>css/<%= pkg_name %>.css"
        dest: "<%= dest_dir %>css/<%= pkg_name %>.min.css"

    watch:
      options:
        livereload: true

      concat:
        files: [
          "<%= concat.js_files.src %>",
          "<%= concat.css_files.src %>"
        ]
        tasks: "concat"

      html_files:
        files: "<%= src_dir %>**/*.html"
        tasks: "htmlmin"

      css_files:
        files: "<%= src_dir %>css/**/*.css"
        tasks: "cssmin"

      js_files:
        files: "<%= src_dir %>js/**/*.js"
        tasks: ["jshint","uglify"]

    connect:
      site:
        options:
          hostname: "*",
          port: 8000

  grunt.loadNpmTasks "grunt-contrib-concat"
  grunt.loadNpmTasks "grunt-contrib-uglify"
  grunt.loadNpmTasks "grunt-contrib-cssmin"
  grunt.loadNpmTasks "grunt-contrib-htmlmin"
  grunt.loadNpmTasks "grunt-contrib-jshint"
  grunt.loadNpmTasks "grunt-contrib-watch"
  grunt.loadNpmTasks "grunt-contrib-connect"

  grunt.registerTask "build" , [
    "concat",
    "uglify",
    "htmlmin",
    "cssmin"
  ]

  grunt.registerTask "default", ["connect","watch"]