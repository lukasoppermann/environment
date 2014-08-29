// ----------------------------------------------
// autoprefixer
//
module.exports = function(grunt, config) {
  return {
		options: {
			browsers: ['last 4 version', 'ie 8', 'ie 9']
		},
		css_files: {
			src: config.cwd+config.package.dirs.css+'/*.css'
		}
    //,
		// js_css: {
		// 	src: config.cwd+config.package.dirs.js+'/**/**/*.css'
		// }
  };
};
