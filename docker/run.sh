#!/bin/sh

# cd /var/www

# echo "Start to migrate db ..."
# php artisan migrate:fresh --seed --force --no-interaction
# echo "Ran php artisan migrate:fresh --seed --force --no-interaction successfully"

# php artisan cache:clear
# php artisan route:cache

/usr/bin/supervisord -c /etc/supervisor.d/supervisord.ini