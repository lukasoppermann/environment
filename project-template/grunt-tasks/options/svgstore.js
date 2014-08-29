// ----------------------------------------------
// svgstore
//
module.exports = function(grunt, config) {
  return {
    options: {
			prefix : 'icon-', // This will prefix each ID
			svg: { // will be added as attributes to the resulting SVG
				id: 'svg_sprite',
				style: 'display: none;'
			},
			cleanup: true,
			formatting : {
				indent_size : 2
			}
		},
		default : {
			files: {
				'<%=cwd+package.dirs.layout%>svg-sprite.svg': ['<%=cwd+package.dirs.devlayout%>icons/*.svg'],
			}
		}
  };
};
