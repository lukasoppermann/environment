# .bash_profile file

# php ini
export PATH=/Applications/MAMP/bin/php/php5.4.10/bin:$PATH

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

# app alias
alias lynx="open -a Lynxlet"

# other aliases
alias unhide="defaults write com.apple.finder AppleShowAllFiles TRUE; killall Finder"
alias hide="defaults write com.apple.finder AppleShowAllFiles FALSE; killall Finder"
alias top="top -o cpu"
alias .="open ."

# alias to projects
alias taskd="cd ~/projects/taskd/prototype"
alias veare="cd ~/projects/veare"
alias vr="cd ~/projects/veare_new"
alias sites="cd ~/projects"
alias projects="cd ~/projects"
alias p="cd ~/projects"
alias packages="cd ~/projects/_packages"

# laravel artisan
alias art="php artisan"

# git path
alias ..="cd ../../"
alias ...="cd ../../../"

# ssh alias
alias ssh-veare="ssh -p 2222 lukas@vea.re"

# for profile
alias reload="source ~/.bash_profile"
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
# add tag with t tagname or remove eith t -tagname
t(){
    if [[ $1 == -* ]] ;
    then
        git tag -d ${1:1}
        git push origin :refs/tags/${1:1}
    else
        git tag $1
    fi

}
alias show="git show"
alias log="git reflog"

alias sub="git submodule"
alias sup="git submodule foreach 'git checkout master; git pull'"

# mysql alias
alias mysql_dir="/Applications/MAMP/Library/bin/"
alias mysql="/Applications/MAMP/Library/bin/mysql -u root -proot"
alias mysqldump="/Applications/MAMP/Library/bin/mysqldump -u root -proot"

export PATH="/usr/local/bin:/usr/local/sbin:~/bin:$PATH"
