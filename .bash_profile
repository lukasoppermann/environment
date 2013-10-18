# Add `~/bin` to the `$PATH`
export PATH="$HOME/bin:$PATH"

# php ini
export PATH=/Applications/MAMP/bin/php/php5.4.10/bin:$PATH

# Load the shell dotfiles, and then some:
dotFilePath="/Users/lukasoppermann/Projects/knowledge-base/"
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in $dotFilePath.{path,bash_prompt,exports,aliases,functions,extra,gits}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file