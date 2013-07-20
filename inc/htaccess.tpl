<Files .htaccess>
order allow,deny
deny from all
</Files>

RewriteEngine on
RewriteBase {{ BETA_ROOT_URL }}

# Set some rewrite environment vars
RewriteRule ^.*$ - [E=STRIPPED_REQUEST:$0]
RewriteRule . - [E=SITE_BASE:{{ BETA_ROOT_PATH }}]

# Serve things in the statics directory as if they were at the root
RewriteCond %{ENV:SITE_BASE}/static/%{ENV:STRIPPED_REQUEST} -f
RewriteRule ^.*$ static/$0 [L]

RewriteCond %{REQUEST_FILENAME} !-f
RewriteCond %{REQUEST_URI} !(.*)/$
RewriteRule ^.*$ $0/ [L,R=301]

# Redirect everything else through the index file
RewriteCond %{ENV:STRIPPED_REQUEST} !^index\.php
RewriteCond %{ENV:STRIPPED_REQUEST} !^static/?
RewriteRule . index.php [L]