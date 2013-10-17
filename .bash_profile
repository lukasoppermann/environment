# Add `~/bin` to the `$PATH`
export PATH="$HOME/bin:$PATH"

# php ini
export PATH=/Applications/MAMP/bin/php/php5.4.10/bin:$PATH

# Load the shell dotfiles, and then some:
dotFilePath="/Users/lukasoppermann/Projects/knowledge-base/"
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in $dotFilePath.{path,bash_prompt,exports,aliases,functions,extra}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

# command alias
alias edit="mate"
# export declaration
# parse_git_branch() {
# 	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ [\1]/'
# }
# export PS1="\u \w\$(parse_git_branch)$ "


# app alias
alias lynx="open -a Lynxlet"

# other aliases
alias unhide="defaults write com.apple.finder AppleShowAllFiles TRUE; killall Finder"
alias hide="defaults write com.apple.finder AppleShowAllFiles FALSE; killall Finder"
alias top="top -o cpu"
alias e="open ."

# laravel artisan
alias art="php artisan"

# ssh alias
alias ssh-veare="ssh -p 2222 veare@vea.re"

alias profile="mate . ~/.bash_profile"
alias aliases="mate . $dotFilePath.aliases"
alias functions="mate . $dotFilePath.functions"
# function e {
# 	if [[ $1 == "" ]] ; then
# 		source ~/.bash_profile
# 	elif [ -f ~/.${1#.} ]; then
# 		source ~/.${1#.}
# 	elif [ -f $dotFilePath.${1#.} ]; then
# 		source $dotFilePath.$1
# 	else
# 		echo "File not found in: ~/.${1#.} and $dotFilePath.${1#.} not found."
# 	fi	
# }
# git composer
alias composer-update="composer self-update; composer update"

# git alias
alias status="git status"
alias st="git status"
alias commit="git commit"
alias clone="git clone"
alias cm="git commit -m"
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




# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# Append to the Bash history file, rather than overwriting it
shopt -s histappend

# Autocorrect typos in path names when using `cd`
shopt -s cdspell

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
	shopt -s "$option" 2> /dev/null
done

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2 | tr ' ' '\n')" scp sftp ssh

# Add tab completion for `defaults read|write NSGlobalDomain`
# You could just use `-g` instead, but I like being explicit
complete -W "NSGlobalDomain" defaults

# Add `killall` tab completion for common apps
complete -o "nospace" -W "Contacts Calendar Dock Finder Mail Safari iTunes SystemUIServer Terminal Twitter" killall

# If possible, add tab completion for many more commands
[ -f /etc/bash_completion ] && source /etc/bash_completion