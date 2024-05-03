
docker-compose build && docker-compose up -d

composer install

chmod -R 775 storage/framework
chmod -R 775 storage/logs
chmod -R 775 bootstrap/cache

chown -R www-data:www-data storage/
chown -R www-data:www-data bootstrap/

pwd
chown -R www-data:www-data /root/Glooping-Api
chmod -R 755 /root/Glooping-Api/storage
chmod -R 755 /root/Glooping-Api/bootstrap

