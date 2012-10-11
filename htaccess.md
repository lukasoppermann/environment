# Htaccess to point URL to subfolder

###############################################################
		# Rewrite for veare
# 
# rewrite plain url with no params
RewriteCond %{HTTP_HOST} ^(www.)?vea.re$ [NC]
RewriteRule ^(/)?$ veare/index.php [L]
# rewrite parameters that are files or folders that exists
RewriteCond $1 !^veare/
RewriteCond %{HTTP_HOST} ^(www.)?vea.re(.*)?$ [NC]
RewriteCond %{DOCUMENT_ROOT}/veare/$1 -f [OR]
RewriteCond %{DOCUMENT_ROOT}/veare/$1 -d
RewriteRule ^(.*)$ veare/$1 [L]
# rewrite parameters that are neither files nor folders
RewriteCond %{HTTP_HOST} ^(www.)?vea.re(.*)?$ [NC]
RewriteCond %{REQUEST_FILENAME} !-f
RewriteCond %{REQUEST_FILENAME} !-d
RewriteRule !^veare/ veare/index.php?/$1 [L]