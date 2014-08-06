/*global module:false*/
module.exports = function(grunt) {
  // Project configuration.
  grunt.initConfig({
    meta: {
			version: '{%= version %}',
			project: '{%= name %}',
			website: 'http://{%= website %}',
			dev_name: '{%= devname %}',
    },
		{% if (min_concat) { %}
    // Metadata.
    banner: '/*! <%= meta.project %> - v<%= meta.version %> - ' +
      '<%= grunt.template.today("yyyy-mm-dd") %>\n' +
      '* <%= meta.website %>\n' +
      '* Copyright (c) <%= grunt.template.today("yyyy") %> ' +
      '<%= meta.dev_name %>; Licensed MIT */\n',

		{% } %}
    // Task configuration.{% if (min_concat) { %}
    concat: {
      options: {
        banner: '<%= banner %>',
        stripBanners: true
      },
      dist: {
        src: ['{%= lib_dir %}/js/*.js'],
        dest: '{%= lib_dir %}/js/application.min.js'
      }
    },
    uglify: {
      options: {
        banner: '<%= banner %>'
      },
      dist: {
        src: '<%= concat.dist.dest %>',
        dest: '<%= concat.dist.dest %>'
      }
    },
		cssmin: {
		  minify: {
		    expand: true,
				files: {
					'{%= lib_dir %}/css/application.min.css': ['{%= lib_dir %}/css/*.css', '!{%= lib_dir %}/css/*.min.css']
				}
		  }
		},
		imagemin: {
      dynamic: {
	      options: {
	        optimizationLevel: 3
	      },
        files: [{
          expand: true,
          cwd: '{%= img_dir %}',   // Src matches are relative to this path
          src: ['*.{png,jpg,gif}'],// Actual patterns to match
          dest: '{%= img_dir %}'   // Destination path prefix
        }]
      }
		},
		{% } %}
    autoprefixer: {
      options: {
        browsers: ['last 4 version', 'ie 8', 'ie 9']
      },
	    multiple_files: {
	      expand: true,
	      flatten: true,
	      src: '{%= lib_dir %}/css/*.css'
	    },
	  },
		csslint: {
      lax: {
        options: {
					'import': 2,
					'box-sizing': false,
					'outline-none': false,
					'ids': false,
					'adjoining-classes': false,
					'box-model': false,
					'fallback-colors': false,
					'compatible-vendor-prefixes': false
        },
        src: ['{%= lib_dir %}/css/*.css']
			},
		},
    jshint: {
      options: {
        curly: true,
        eqeqeq: true,
        immed: true,
        latedef: true,
        newcap: true,
        noarg: true,
        sub: true,
        undef: true,
        unused: true,
        boss: true,
        eqnull: true,
        browser: true,
        globals: {{% if (jquery) { %}
          jQuery: true
        {% } %}}
      },
      // gruntfile: {
      //   src: 'Gruntfile.js'
      // },
      lib_test: {
        src: ['{%= lib_dir %}/**/*.js', '{%= test_dir %}/**/*.js']
      }
    },{% if (test) { %}
    {%= test_task %}: {
      files: ['{%= test_dir %}/**/*.html']
    },{% } else { %}
    {%= test_task %}: {
      files: ['{%= test_dir %}/**/*_test.js']
    },{% } %}
		// svgsprite: {
		// 	spriteCSS: {
		// 	  src: '{%= img_dir %}/icons/',
		// 	  dest: '{%= img_dir %}',
		// 		options: {
		// 	        render: {
		// 	          css: {
		// 
		// 				}
		// 	        },
		// 			common: 'icon',
		// 	        maxwidth: 50,
		// 	        maxheight: 50,
		// 	        padding: 10,
		// 			sprite: 'svg-icon-sprite',
		// 			spritedir: '',
		// 	        keep: false,
		// 	        dims: false,
		// 			cleanwith: 'svgo'
		// 	      }
		// 	}
		// },
		svgstore: {
	    options: {
	      prefix : 'icon-', // This will prefix each ID
	      svg: { // will be added as attributes to the resulting SVG
					id: 'svg_sprite'
	      },
			  formatting : {
					indent_size : 2
				}
	    },
	    default : {
	      files: {
	        'layout/svg-sprite.svg': ['layout/icons/*.svg'],
	      },
	    },
	  },
    watch: {
      gruntfile: {
        files: '<%= jshint.gruntfile.src %>',
        tasks: ['jshint:gruntfile']
      },
      lib_test: {
        files: '<%= jshint.lib_test.src %>',
        tasks: ['jshint:lib_test'{%= test ? ", 'test_task'": "" %}]
      },
		  svg_sprite: {
		    files: ['{%= img_dir %}/**/*.svg'],
		    tasks: ['svgstore'],
			}
    }
  });

  // These plugins provide necessary tasks.{% if (min_concat) { %}
  grunt.loadNpmTasks('grunt-contrib-concat');
	grunt.loadNpmTasks('grunt-contrib-cssmin');
	// https://www.npmjs.org/package/grunt-contrib-imagemin
	grunt.loadNpmTasks('grunt-contrib-imagemin');
  grunt.loadNpmTasks('grunt-contrib-uglify');{% } %}
	{% if (test) { %}grunt.loadNpmTasks('grunt-contrib-{%= test_task %}');{% } %}
  grunt.loadNpmTasks('grunt-contrib-jshint');
	grunt.loadNpmTasks('grunt-contrib-csslint');
  grunt.loadNpmTasks('grunt-contrib-watch');
	//https://www.npmjs.org/package/grunt-autoprefixer
	grunt.loadNpmTasks('grunt-autoprefixer');
	grunt.loadNpmTasks('grunt-svg-sprite');
	grunt.loadNpmTasks('grunt-svgstore');
  // Default task.
	grunt.registerTask('default', ['jshint', 'csslint', 'autoprefixer'{%= test ? ",'"+test_task+"'": "" %}]);
  // Build task.
	grunt.registerTask('build', ['jshint', 'csslint', 'autoprefixer'{%= test ? ",'"+test_task+"'": "" %}{%= min_concat ? ", 'concat', 'uglify', 'cssmin'" : "" %}]);

};
