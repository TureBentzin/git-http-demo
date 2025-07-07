#!/bin/bash
set -e

# Bare-Repo if not exists
if [ ! -d "/srv/git/testrepo.git" ]; then
  cd /srv/git
  git init --bare testrepo.git

  git clone /srv/git/testrepo.git /tmp/tmprepo
  cd /tmp/tmprepo
  echo "Hello from D1" > README.md
  git add README.md
  git commit -m "Initial commit"
  git push origin master
  rm -rf /tmp/tmprepo
fi

# Fix permissions
chown -R www-data:www-data /srv/git
chmod -R 755 /srv/git

# Apache Config
cat >/etc/apache2/sites-available/000-default.conf <<EOF
<VirtualHost *:80>
    ServerAdmin webmaster@localhost
    DocumentRoot /srv/git

    SetEnv GIT_PROJECT_ROOT /srv/git
    SetEnv GIT_HTTP_EXPORT_ALL

    ScriptAlias /git/ /usr/lib/git-core/git-http-backend/

    <Directory "/usr/lib/git-core">
        Options +ExecCGI -MultiViews +SymLinksIfOwnerMatch
        Require all granted
    </Directory>

    <Directory "/srv/git">
        Require all granted
    </Directory>
</VirtualHost>
EOF

a2enmod cgi
a2ensite 000-default

touch /srv/git/testrepo.git/git-daemon-export-ok

apachectl -D FOREGROUND
