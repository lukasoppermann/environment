# Htaccess to point URL to folder

RewriteEngine on
RewriteCond %{HTTP_HOST} ^(www.)?vea.re(.*)?$ [NC]
RewriteCond %{REQUEST_URI} !^/veare/
RewriteCond %{REQUEST_FILENAME} !-f
RewriteCond %{REQUEST_FILENAME} !-d
RewriteRule ^(.*)$ /veare/index.php?/$1
RewriteCond %{HTTP_HOST} ^(www.)?vea.re$ [NC]
RewriteRule ^(/)?$ veare/index.php [L]