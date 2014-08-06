/*
 * grunt-init-gruntfile
 * https://gruntjs.com/
 *
 * Copyright (c) 2012 "Cowboy" Ben Alman, contributors
 * Licensed under the MIT license.
 */

'use strict';

// Basic template description.
exports.description = 'Create a basic Gruntfile.';

// Template-specific notes to be displayed before question prompts.
exports.notes = 'This template tries to guess file and directory paths, but ' +
  'you will most likely need to edit the generated Gruntfile.js file before ' +
  'running grunt. _If you run grunt after generating the Gruntfile, and ' +
  'it exits with errors, edit the file!_';

// Any existing file or directory matching this wildcard will cause a warning.
exports.warnOn = 'Gruntfile.js';

// The actual init template.
exports.template = function(grunt, init, done) {

  init.process({}, [
		init.prompt('name'),
		init.prompt('description'),
		init.prompt('version'),
    // Prompt for these values.
    {
      name: 'website',
      message: 'Whats the projects website? http://...',
      default: ''
    },
    {
      name: 'devname',
      message: 'Whats the developers name / company name?',
      default: ''
    },
    {
      name: 'test',
      message: 'Do you need unit-tests? (y/N)',
      default: 'N',
      warning: 'Yes: QUnit unit tests + JSHint "browser" globals. No: Nodeunit unit tests.'
    },
    {
      name: 'min_concat',
      message: 'Will files be concatenated or minified? (Y/n)',
      default: 'Y',
      warning: 'Yes: min + concat tasks. No: nothing to see here.'
    }
  ], function(err, props) {
		props.test = /y/i.test(props.test);
    props.min_concat = /y/i.test(props.min_concat);
    props.package_json = true;
		props.test_task = 'qunit';
		props.file_name = '<%= pkg.name %>';

    // Find the first `preferred` item existing in `arr`.
    function prefer(arr, preferred) {
      for (var i = 0; i < preferred.length; i++) {
        if (arr.indexOf(preferred[i]) !== -1) {
          return preferred[i];
        }
      }
      return preferred[0];
    }

    // Guess at some directories, if they exist.
    var dirs = grunt.file.expand({filter: 'isDirectory'}, '*,*/*,*/*/*').map(function(d) { return d.slice(0, -1); });
    props.img_dir = prefer(dirs, ['layout', 'media']);
    props.lib_dir = prefer(dirs, ['libs', 'lib', 'src']);
    props.test_dir = prefer(dirs, ['test', 'tests', 'unit', 'spec']);

    // Maybe this should be extended to support more libraries. Patches welcome!
    props.jquery = grunt.file.expand({filter: 'isFile'}, '**/jquery*.js').length > 0;

    // Files to copy (and process).
    var files = init.filesToCopy(props);

    // Actually copy (and process) files.
    init.copyAndProcess(files, props);


    // If is package_json true, generate package.json
    if (props.package_json) {
      var devDependencies = {
        'grunt': '~0.4.2',
        'grunt-contrib-jshint': '~0.7.2',
        'grunt-contrib-watch': '~0.5.3',
				'grunt-autoprefixer': '~0.7.3',
				'grunt-contrib-csslint': '~0.2.0',
				'grunt-svg-sprite': '~0.2.0',
				"grunt-svgstore": "~0.0.4"
      };

      if (props.test) {
	      devDependencies['grunt-contrib-qunit'] = '~0.3.0';
			}

      if (props.min_concat) {
        devDependencies['grunt-contrib-concat'] = '~0.3.0';
        devDependencies['grunt-contrib-uglify'] = '~0.2.7';
				devDependencies['grunt-contrib-cssmin'] = '~0.9.0';
				devDependencies['grunt-contrib-imagemin'] = '~0.7.0';
      }

      // Generate package.json file, used by npm and grunt.
      init.writePackageJSON('package.json', {
				name: props.name,
				description: props.description,
				version: props.version,
				"private": true,
        node_version: '>= 0.10.0',
        devDependencies: devDependencies
      });
    }

    // All done!
    done();
  });

};
