# Base Setup

copy the following into your .bash_profile file to build a new directory with the files from base setup by using `m name_of_project` in the terminal.
To have the folder structure setup, add `-dir` (`m name_of_project -dir`).

# build alias

    function m { 
    	if [ "$2" = "-empty" ] || [ "$3" = "-empty" ]; then
    		mkdir $1
    		cd $1
    		wget https://raw.github.com/lukasoppermann/base-setup/master/.gitignore
    		echo "# $1" > readme.md
		else
    		git clone https://github.com/lukasoppermann/base-setup.git $1
    		cd $1
    		rm -rf .git
    		rm readme.md
    		echo "# $1" > readme.md
    		cd layout
    		rm -rf readme.md
    		cd ../media
    		rm -rf readme.md
    		cd ..
    		if [ "$2" != "" ]; then
    			git init
    			git add .
    			git commit -m 'init'
    			git remote add origin $2
    			git push -u origin master
			fi
    	fi
    	open .
    }