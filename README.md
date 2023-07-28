
# WordPress Site on Dockerized LEMP Stack

The project provides a command-line script written in bash to easily create, manage, enable, disable, and delete WordPress sites using Docker Compose with LEMP Stack setup. It provides a simple and automated way to set up and manage  WordPress site on your server.



## Prerequisites

Before running this project , you need to setup an EC2 Instance on Amazon Web Services(AWS) using Amazon Linux AMI. During setting up of EC2 Instance make sure to keep port 80 and port 3306 open in security group of the instance.

After setting up the instance and logging into the instance , you need to run the following commands as a prerequisite for the project to run successfully.

Install git using yum package manager

```bash
  sudo yum install git -y
```

After installing git you need to install lynx which is a terminal-based web browser for all Linux distributions. It shows the result as plain text on the terminal

```bash
  sudo yum install lynx -y
```


## Steps To Run the Project

Clone the project

```bash
  git clone https://link-to-project
```

Go to the project directory

```bash
  cd my-project
```

Give permissions to the script

```bash
  chmod a+x bash file
```



## Usage

To successfully launch the wordpress website , navigate to the directory where the wordpress_manager.sh script is located.

### Command Syntax
 The command syntax for using the script is as follows:

```bash
  ./wordpress_manager.sh <command> <site_name>
``` 
Where:

1) <command> is one of the following: create, enable, disable, or delete.
2) <site_name> is the desired name for your WordPress site (e.g., example.com).

### Sub-Commands

#### Create Command :- 

The create command allows you to create a new WordPress site using Docker Compose with the LEMP stack.

```bash
  ./wordpress_manager.sh create <site_name>
``` 
<site_name>: Specify the name for your WordPress site.
The create command will perform the following tasks:

1) Set up a new directory with the provided <site_name>.
2) Create the necessary Nginx configuration file and Dockerfile for PHP customization.
3) Generate a Docker Compose file to set up the Nginx, PHP, and MySQL containers for the WordPress site.
4) Prompt you to open the site in your browser once it's up and healthy.
&nbsp;


#### Enable/Disable Commands :-

The enable and disable commands allow you to start or stop the containers for a specific WordPress site.

1) The enable command will start the containers for the specified site, making it accessible.

```bash
  ./wordpress_manager.sh enable <site_name>
``` 
2) The disable command will stop the containers for the specified site, making it inaccessible.

```bash
  ./wordpress_manager.sh disable <site_name>
``` 
<site_name>: Specify the name of the WordPress site you want to enable or disable.

#### Delete Command :-

The delete command allows you to delete a WordPress site, including stopping the containers and removing local files.

```bash
  ./wordpress_manager.sh delete <site_name>
``` 
The delete command will perform the following tasks:

1) Stop and remove the containers associated with the site.
2) Remove the local directory for the site.




## Screenshots

![App Screenshot](https://via.placeholder.com/468x300?text=App+Screenshot+Here)


## Authors

- [@octokatherine](https://www.github.com/octokatherine)

