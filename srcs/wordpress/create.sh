cd /var/www/;
mkdir -p wordpress;
cd wordpress;

if ! $(wp core is-installed); then
    wp core download --version=latest;

    while true; do
       if wp config create --dbname=wordpress --dbuser=admin --dbpass=admin --dbhost=mysql; then
            break;
        fi;

        sleep 2;
    done;

    wp core install --url=http://172.17.0.3:5050 --title=ft_services --admin_user=thervieu --admin_password=AStrongPassword123 --admin_email=example@example.com;
    wp user create author_example author@example.com --role=author ;
    wp user create contributor contributor@example.com --role=contributor;
    wp user create user_1 user1@example.com;
    wp user create user_2 user2@example.com;
    wp user create user_123 user123@example.com;

fi