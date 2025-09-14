#!/bin/sh
composer install --no-dev --optimize-autoloader
php artisan config:cache
php artisan route:cache
php artisan migrate --force  # Runs on deploy
# Pipe logs to stdout for Railway
php artisan log-channel:stack daily 2>&1 | tee /dev/stderr &
supervisord -c /etc/supervisord.conf

# #!/bin/sh
# composer install --no-dev --optimize-autoloader
# php artisan config:cache
# php artisan route:cache
# php artisan view:cache
# php artisan migrate --force
# php -S 0.0.0.0:80 -t public

