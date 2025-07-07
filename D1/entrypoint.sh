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

# Apache Config
cat >/etc/apache2/sites-available/000-default.conf <<EOF
<VirtualHost *:80>
    ServerAdmin webmaster@localhost
    DocumentRoot /srv/git

    SetEnv GIT_PROJECT_ROOT /srv/git
    SetEnv GIT_HTTP_EXPORT_ALL
    ScriptAlias /git/ /usr/lib/git-core/git-http-backend/
</VirtualHost>
EOF

# https://git-scm.com/docs/git-daemon
touch /srv/git/testrepo.git/git-daemon-export-ok

# Starte Apache im Vordergrund
apachectl -D FOREGROUND
