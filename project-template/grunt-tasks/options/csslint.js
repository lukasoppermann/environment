// ----------------------------------------------
// svgstore
//
module.exports = function(grunt, config) {
  return {
    lax: {
      options: {
        import: false,
        "box-sizing": false,
        "box-model": false
      },
      src: [config.cwd+config.package.dirs.css+'*.css']
    }
  };
};
