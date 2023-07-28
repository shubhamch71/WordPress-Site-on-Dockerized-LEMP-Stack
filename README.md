
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
  git clone https://github.com/shubhamch71/WordPress-Site-on-Dockerized-LEMP-Stack.git
```

Go to the project directory

```bash
  cd WordPress-Site-on-Dockerized-LEMP-Stack
```

Give permissions to the script

```bash
  chmod a+x wp_lemp.sh
```



## Usage

To successfully launch the wordpress website , navigate to the directory where the wordpress_manager.sh script is located.

### Command Syntax
 The command syntax for using the script is as follows:

```bash
  ./wp_lemp.sh <command> <site_name>
``` 
Where:

1) <command> is one of the following: create, enable, disable, or delete.
2) <site_name> is the desired name for your WordPress site (e.g., example.com).

### Sub-Commands

#### Create Command :- 

The create command allows you to create a new WordPress site using Docker Compose with the LEMP stack.

```bash
  ./wp_lemp.sh create <site_name>
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
  ./wp_lemp.sh enable <site_name>
``` 
2) The disable command will stop the containers for the specified site, making it inaccessible.

```bash
  ./wp_lemp.sh disable <site_name>
``` 
<site_name>: Specify the name of the WordPress site you want to enable or disable.

#### Delete Command :-

The delete command allows you to delete a WordPress site, including stopping the containers and removing local files.

```bash
  ./wp_lemp.sh delete <site_name>
``` 
The delete command will perform the following tasks:

1) Stop and remove the containers associated with the site.
2) Remove the local directory for the site.




## Demo
After doing the prerequisites, following is the demo output of the project

### Create Subcommand

1) After running the create subcommand , the script checks for docker and docker-compose and installs them if it is  not installed . 
&nbsp;

![image](https://github.com/shubhamch71/WordPress-Site-on-Dockerized-LEMP-Stack/assets/83663663/1af4fc53-28ff-4d67-82c4-f56b9cbcb98a)

![image](https://github.com/shubhamch71/WordPress-Site-on-Dockerized-LEMP-Stack/assets/83663663/1d39db61-ed12-49ab-92e5-4de60e06ce4f)

![image](https://github.com/shubhamch71/WordPress-Site-on-Dockerized-LEMP-Stack/assets/83663663/75dd1597-0c05-49a1-825f-ee26f66cd03a)
&nbsp;

2) After docker-compose is installed it creates the docker containers and launches the Wordpress site after a health check is done successfully.
&nbsp;

![image](https://github.com/shubhamch71/WordPress-Site-on-Dockerized-LEMP-Stack/assets/83663663/9a56dd26-1a7d-4a21-aee5-a3661f5c2a25)

&nbsp;

3) You are prompted to open the Wordpress site in using lynx in the command line itself. Please type Y to open it in lynx.
&nbsp;

![image](https://github.com/shubhamch71/WordPress-Site-on-Dockerized-LEMP-Stack/assets/83663663/fecf06a6-d6d3-43e5-b44a-4cf396e1368d)
&nbsp;

4) After opening it in lynx you can see the installation page of Wordpress site which indicates the successful setup of Wordpress site using lemp stack . *(Note this installation setup is required only for the first time)*. To exit lynx you can traverse to the bottom of page using down arrow key and then press q to quit and press y .
&nbsp;
![image](https://github.com/shubhamch71/WordPress-Site-on-Dockerized-LEMP-Stack/assets/83663663/7c6df189-72a1-4551-ba8f-1137adb67a5e)

![image](https://github.com/shubhamch71/WordPress-Site-on-Dockerized-LEMP-Stack/assets/83663663/17e2121e-455b-45e6-8196-d83557edd5f1)
&nbsp;

5) You can also open the site on external browser by copy pasting the ec2 instance public ip address.
 *(Optional - You can directly open the website by typing the website name in external browser if you have the domain for the same.)*

&nbsp;

![image](https://github.com/shubhamch71/WordPress-Site-on-Dockerized-LEMP-Stack/assets/83663663/69611731-499b-4d32-916e-b05811db9452)

### Disable Subcommand 
1) After running the disable subcommand the conatiners are stopped .
&nbsp;
![image](https://github.com/shubhamch71/WordPress-Site-on-Dockerized-LEMP-Stack/assets/83663663/9ed01a98-4b36-4648-875d-3053de79851c)


### Enable Subcommand 
1) After running the enable subcommand the conatiners are started again and now you can access the wordpress site .
&nbsp;
![image](https://github.com/shubhamch71/WordPress-Site-on-Dockerized-LEMP-Stack/assets/83663663/3c263c04-ac55-4f2c-ab41-9246f6cac293)

### Delete Subcommand 
1) After running the delete subcommand the conatiners are stopped and removed and the directory of wordpress site si deleted .
&nbsp;
![image](https://github.com/shubhamch71/WordPress-Site-on-Dockerized-LEMP-Stack/assets/83663663/0388d08c-e079-4d68-96ff-1a190534c448)




## Authors

- [@shubhamch71](https://github.com/shubhamch71)

