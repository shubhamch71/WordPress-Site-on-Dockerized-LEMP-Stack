#!/bin/bash


# Function to check if a command is installed
function is_installed {
    command -v "$1" >/dev/null 2>&1
}

# Check if Docker is installed
if is_installed docker; then
    echo "Docker is already installed."
else
    echo "Docker is not installed. Installing Docker..."
    sudo yum install docker -y
    # Add the current user to the docker group to run docker 
    sudo usermod -aG docker $USER
    sudo systemctl start docker 
    sudo systemctl enable docker 
    sudo chmod 777 /var/run/docker.sock
    echo "Docker has been installed successfully."
fi

# Check if Docker Compose is installed
if is_installed docker-compose; then
    echo "Docker Compose is already installed."
else
    echo "Docker Compose is not installed. Installing Docker Compose..."
    # Install Docker Compose using the official installation instructions
    sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    echo "Docker Compose has been installed successfully."
fi

# Function to create the WordPress site using Docker Compose
create_wordpress_site() {
    if [ -z "$1" ]; then
        echo "Error: Site name not provided."
        exit 1
    fi

    site_name="$1"
    alt_name="http://localhost/$site_name"
   

    # Create the WordPress directory and Docker Compose file
    mkdir -p "$site_name"
    cd "$site_name" || exit 1

    # Create the Nginx configuration file
    cat <<EOF >nginx.conf
server {
    listen 80;
    server_name $site_name;

    location / {
        proxy_pass http://wordpress:80;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
    }
}
EOF

    # Create the WordPress Dockerfile for custom PHP configurations 
    cat <<EOF >Dockerfile
FROM wordpress:php7.4-fpm

RUN docker-php-ext-install mysqli
EOF

    # Create the docker-compose.yml file
    cat <<EOF >docker-compose.yml
version: '3'
services:
  db:
    image: mysql:5.7
    restart: always
    environment:
      MYSQL_DATABASE: wordpress
      MYSQL_USER: wordpress
      MYSQL_PASSWORD: wordpress
      MYSQL_ROOT_PASSWORD: rootpasswd
    volumes:
      - db_data:/var/lib/mysql
  wordpress:
    build:
      context: .
      dockerfile: Dockerfile
    image: wordpress:latest
    restart: always
    depends_on:
      - db
    environment:
      WORDPRESS_DB_HOST: db:3306
      WORDPRESS_DB_USER: wordpress
      WORDPRESS_DB_PASSWORD: wordpress
      WORDPRESS_DB_NAME: wordpress
    volumes:
      - ./wp-content:/var/www/html/wp-content
  nginx:
    image: nginx:latest
    restart: always
    volumes:
      - ./nginx.conf:/etc/nginx/conf.d/default.conf
    ports:
      - 80:80
volumes:
  db_data:
EOF

    # Create the wp-content directory
    mkdir -p wp-content

    # Create /etc/hosts entry
    echo "127.0.0.1 $site_name" | sudo tee -a /etc/hosts
    echo "127.0.0.1 $alt_name" | sudo tee -a /etc/hosts
    # Start the containers
    docker-compose up -d

    echo "WordPress site '$site_name' has been created and is accessible at http://$site_name or you can copy paste your ec2 instance public ip in your external browser"
    
    # Wait for the site to be up and healthy
    echo "Waiting for the site to be up and healthy..."
    while ! curl -s http://$site_name >/dev/null; do
        sleep 2
    done

    # Prompt the user to open the site in a browser
    echo "The site is up and healthy. Do you want to open http://$site_name in your browser (lynx)? (y/n). After viewing the site , to exit lynx you can traverse to the bottom of page using down arrow key and then press q to quit and press y"
    read -r choice
    if [ "$choice" == "y" ] || [ "$choice" == "Y" ]; then
	sleep 2
        lynx "http://$site_name"  # Modify this line for non-Ubuntu systems
    else
         echo " You can also open it in external browser by pasting ip address of your ec2 instance or http://localhost/$site_name or $site_name if you have the domain for the same"
    fi
}
   
   
# Function to enable/disable the site (stopping/starting the containers)
enable_disable_site() {
    if [ -z "$1" ]; then
        echo "Error: Site name not provided."
        exit 1
    fi

    site_name="$1"
    alt_name="http://localhost/$site_name"

    cd "$site_name" || exit 1

    if docker-compose ps | grep -q "wordpress"; then
        docker-compose stop
        echo "Site '$site_name' has been disabled."
    else
        docker-compose start
        echo "Site '$site_name' has been enabled."
    fi
}

# Function to delete the site (containers and local files)
delete_site() {
    if [ -z "$1" ]; then
        echo "Error: Site name not provided."
        exit 1
    fi

    site_name="$1"

    cd "$site_name" || exit 1

    docker-compose down
    cd ..
    sudo rm -rf "$site_name"

    # Remove /etc/hosts entry
    sudo sed -i "/^127.0.0.1 $site_name$/d" /etc/hosts
    sudo sed -i "/^127.0.0.1 $alt_name$/d" /etc/hosts
    echo "Site '$site_name' has been deleted."
}

# Main script starts here
if [ "$#" -lt 2 ]; then
    echo "Usage: $0 <command> <site_name>"
    echo "Commands: create, enable/disable, delete"
    exit 1
fi

command="$1"
site_name="$2"

case "$command" in
    "create")
        create_wordpress_site "$site_name"
        ;;
    "enable")
        enable_disable_site "$site_name"
        ;;
    "disable")
        enable_disable_site "$site_name"
        ;;
    "delete")
        delete_site "$site_name"
        ;;
    *)
        echo "Invalid command: $command"
        echo "Commands: create, enable/disable, delete"
        exit 1
        ;;
esac

