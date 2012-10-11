# .bash_profile file

# command alias
alias ls='ls -G'
alias edit="mate"
# export declaration
parse_git_branch() {
	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ [\1]/'
}
export PS1="\u \w\$(parse_git_branch)$ "
export EDITOR='~/bin/mate2 -w'
export PATH=/usr/local/bin:/usr/local/sbin:$PATH
export CC=/opt/local/bin/clang

# alias to projects
alias thesis="cd ~/projects/thesis/03_thesis"
alias veare="cd ~/sites/veare"
alias sites="cd ~/sites"
alias fs="cd ~/sites/formandsystem_future"
alias ci="cd ~/sites/ci_formandsystem_2.1.2"
alias js="cd ~/sites/_snippets"

# git path
alias ..="cd ../../"
alias ...="cd ../../../"

# ssh alias
alias ssh-veare="ssh -p 2222 lukas@vea.re"
alias ssh-buchla="ssh -p 2222 buchla@174.121.133.187"

# for profile
alias reload_profile="source ~/.bash_profile"
alias profile="mate . ~/.bash_profile"

# git alias
alias status="git status"
alias st="git status"
alias commit="git commit"
alias clone="git clone"
alias c="git commit -m"
cur_git_branch() {
	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}
alias push="git push --tags origin \$(cur_git_branch)"
alias pull="git pull"
alias add="git add"
alias ca="git commit -am"
alias ck="git checkout"
alias b="git branch"
alias tag="git tag -a"
alias show="git show"
alias log="git reflog"

alias sub="git submodule"
alias sup="git submodule foreach 'git checkout master; git pull'"

# mysql alias
alias mysql_dir="/Applications/MAMP/Library/bin/"
alias mysql="/Applications/MAMP/Library/bin/mysql -u root -proot"
alias mysqldump="/Applications/MAMP/Library/bin/mysqldump -u root -proot"

export PATH="/usr/local/bin:/usr/local/sbin:~/bin:$PATH"
