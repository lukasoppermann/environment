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
alias knowledge="cd ~/projects/knowledge-base<"
alias styleguide="cd ~/projects/zupply/styleguide"
alias taskd="cd ~/projects/taskd/prototype"
alias veare="cd ~/projects/veare"
alias vr="cd ~/projects/veare_new"
alias sites="cd ~/projects"
alias projects="cd ~/projects"
alias p="cd ~/projects"
alias fs="cd ~/projects/formandsystem_future"
alias ci="cd ~/projects/ci_formandsystem"
alias cisub="cd ~/projects/ci_formandsystem/system/packages/"
alias packages="cd ~/projects/_packages"
alias basemodel="cd ~/projects/_packages/fs_base_model"

# laravel artisan
alias art="php artisan"

# git path
alias ..="cd ../../"
alias ...="cd ../../../"

# ssh alias
alias ssh-veare="ssh -p 2222 veare@vea.re"

# for profile
alias reload="source ~/.bash_profile"
alias profile="mate . ~/.bash_profile"

# git composer
alias composer-update="composer self-update; composer update"

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
alias add.="git add --all"
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
alias sup="git submodule foreach 'git checkout master; git pull;'"
# alias sup[$1]="cd system/packages/fs_base_model git checkout master; git pull; ...'"
# function smup() { "cd system/packages/$@ git checkout master; git pull; ...";}


# mysql export var
mysql[veare]="veare"
# dir[veare]="/projects/veare"
# ${dir[$1]}

# mysql paths
# alias myex="/Applications/MAMP/Library/bin/mysqldump -u root -proot --skip-extended-insert veare > ~/sites/veare/mysql_veare.sql && cd ~/sites/veare/ && git add mysql_veare.sql"
my_ex(){
	export name=$1
	/Applications/MAMP/Library/bin/mysqldump -u root -proot --skip-extended-insert ${mysql[$name]} > $PWD/${mysql[$1]}.sql
	git add ${mysql[$1]}.sql -f
}
# mysql alias
alias mysql_dir="/Applications/MAMP/Library/bin/"
alias mysql="/Applications/MAMP/Library/bin/mysql -u root -proot"
alias mysqldump="/Applications/MAMP/Library/bin/mysqldump -u root -proot"

export PATH="/usr/local/bin:/usr/local/sbin:~/bin:$PATH"
