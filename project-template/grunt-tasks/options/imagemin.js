// ----------------------------------------------
// imagemin
//
module.exports = function(grunt, config) {
	return {
		dynamic: {
			options: {
				optimizationLevel: 3
			},
			files: [{
				expand: true,
				cwd: config.cwd+config.package.dirs.devmedia, // Src matches are relative to this path
				src: ['*.{png,jpg,gif}'], // Actual patterns to match
				dest: config.cwd+config.package.dirs.media, // Destination path prefix
			}]
		}
	};
};
