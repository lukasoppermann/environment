// ----------------------------------------------
// release branch
//
module.exports = function(grunt, config) {
  return {
    options: {
      //the name of the orphan branch. Default is gh-pages
      releaseBranch: 'build',
      //the name of the remote repository. Default is origin
      remoteRepository: 'server',
      //the name of the output directory. Default is dist
      distDir: 'dist',
      //the commit message to be used for the optional commit
      commitMessage: 'RELEASE',
      //should files be automatically commited on the orphan branch
      commit: true,
      //should the orphan branch be pushed to the remote repository
      //default is false
      push: true,
      //should the branch be an orphan branch
      //default is false
      orphan: true,
      //a blacklist of things to keep on the root level. By default only
      //the .git folder will be kept.
      blacklist: [
          '.git'
      ]
    }
  };
};
