// module exports
module.exports = function(grunt) {

	var path = require('path');
	// get config from package file
	var config = {
		pkg: grunt.file.readJSON('package.json'),
		env: process.env
	};

	// merge task config with main config
	// grunt.util._.extend(config, loadConfig());
	config = grunt.util._.extend(config,
		require('load-grunt-config')(grunt, {
			configPath: path.join(process.cwd(), config.pkg.dirs["task-options"]),
			loadGruntTasks: false,
			init: false,
			data: {
				cwd: process.cwd()+'/'
			}
		}),
		require('load-grunt-config')(grunt, { // Custom options have precedence
			configPath: path.join(__dirname, 'grunt-tasks/custom-options'),
			init: false
		})
	);

	// load all grunt tasks matching the `grunt-*` pattern
	require('load-grunt-tasks')(grunt, {pattern: config.pkg["load-tasks-pattern"]});
	// load my tasks
	grunt.loadTasks(config.pkg.dirs.tasks);

	grunt.initConfig(config);

	// Project configuration.
	var pkg = grunt.file.readJSON('package.json');

	// Tasks
	for( var task in pkg.tasks )
	{
		grunt.registerTask(task, pkg.tasks[task]);
	}

};
