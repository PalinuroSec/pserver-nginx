#Updated nginx server based on debian 9

https://github.com/PalinuroSec/pserver-nginx


# Run

 docker run --name <instance_name> -v <site_name>:/var/www/html -v <site_log>:/var/log/nginx pserver/nginx:<version>

example:
 docker run --name mysite -v /home/user/mywebsite:/var/www/html -v /home/user/mywebsite_logs:/var/log/nginx pserver/nginx:latest


# Build
git pull https://github.com/PalinuroSec/pserver-nginx
cd pserver-nginx
docker build -t nginx:<version> .
