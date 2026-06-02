Local apache httpd settings for mac

    User [user]
    
    AddHandler cgi-script .cgi .xml .py

    <Directory "[path/to/public/folder/ending/with/slash/]">
        # directory specific options
        Options -Indexes +FollowSymLinks +ExecCGI
        
        # directory's index file
        DirectoryIndex web.py

        # rewrite rule
        RewriteEngine on

        # condition 1:
        # ignore app.html, blank.html, unsupported.html
        RewriteCond %{REQUEST_URI} ^((?!app\.html|blank\.html|unsupported\.html).)*$

        # condition 2: if there are no slashes
        # and file is .html or does not containt a .
        # RewriteCond %{REQUEST_URI} ^(?!.+/)((.+\.html)|([^.]+))$
        RewriteCond %{REQUEST_URI} ^(?!.+public/.+/)((.+\.html)|([^.]+))$

        # rewrite if both of the above conditions are true
        RewriteRule ^(.+)$ web.py?page=$1 [NC,L]

        AllowOverride all
        Order Allow,Deny
        Allow from all
    </Directory>
