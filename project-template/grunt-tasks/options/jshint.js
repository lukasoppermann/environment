// ----------------------------------------------
// jshint
//
module.exports = function(grunt, config) {
  return {
    all: ['Gruntfile.js','grunt-tasks/*/*.js'],
    files: ['Gruntfile.js','grunt-tasks/*/*.js',
      config.cwd+config.package.dirs.js+'*.js',
      '!'+config.cwd+config.package.dirs.js+'*.min.js'
    ],
    options: {
      browser: true,
      globals: {
        "jQuery": true,
        "require": true
      }
    }
  };
};
