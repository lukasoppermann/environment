# Knowledge about git

## Setting up git-subtree (for git 1.7.12.1)
1. cd /usr/local/share/git-core/contrib/subtree
2. make 
3. make clean
4. sudo make prefix=/usr/local/Cellar/git/1.7.12.1 install 

## Setup automatic deployment from github

### ssh/config
~/.ssh/config
> Host github.com
> User oppermann.lukas@googlemail.com
> Port 443
> Hostname ssh.github.com

### bash_profile
~/.bash_profile
> eval $(ssh-agent)

### clone git repo 
git clone --recursive git://github.com/mysociety/whatdotheyknow.git
> recursive initialises submodules
>> If your submodule was added in a branch be sure to include it in your clone command... git clone -b <branch_name> --recursive <remote> <directory>

### deploy key
to authorise the server create a deploy key
1. cd ~/.ssh
2. `ssh-keygen -t rsa -C email@mail.com`
3. cat ~/.ssh/id_rsa.pub
4. github.com/user/repo/admin/keys > add key > paste key

### github.php
echo `git pull && git submodule update --init --recursive 2>&1`;

1. github.com/user/repo/admin/
2. Service Hooks
3. add WebHook URLs link to github.php


## Stop ssh access from asking for password
1. cd ~/.ssh
2. if id_rsa.pub does NOT exist: 
`ssh-keygen -t rsa`
3. if ssh-copy-id is installed
`ssh-copy-id '-p 2222 -i id_rsa.pub user@host'` (do not forget the '')
else
open file and copy key
4. ...


## using https without confirming the pw every time