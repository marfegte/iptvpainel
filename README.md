# IPTV Content Management System

## Introduction

**IPTVM** is short for IPTV Content Management System based on **yii** framework, which not only can manage basic IPTV information of Set-Top Box including accounts, products, etc. , but also can monitor and control the  remote servers where streams deployed on. 

## Installation

IPTVM is available on GitHub, you can clone and install it as follows:

**Windows**

* $ git clone https://github.com/AlexanderJLiu/IPTVM.git
* Install [WAMPServer](http://www.wampserver.com/en/) or [XAMPP](https://www.apachefriends.org/index.html)
* Copy IPTVM to the www/ directory of WAMPServer's installation path
* Use phpmyadmin or other MySQL GUI tools to import database/iptvm.sql
* Samples are in database/examples.sql file which contains admin information
* You should config the config/db.php whose information should equal to your local db
* Access http://localhost/IPTVM/web/index.php for login
* Default username is admin and password is admin123

**Linux**

* $ git clone https://github.com/AlexanderJLiu/IPTVM.git
* Install Apache, PHP and its extensions e.g. php-mysql etc, MySQL
* Copy IPTVM to /var/www/html
* Start Apache and MySQL, import the sql files
* You should config the config/db.php whose information should equal to your local db
* Access http://localhost/IPTVM/web/index.php for login
* Default username is admin and password is admin123

## Monitor Servers & Streams

If you want to monitor your own servers and streams, and get the **CPU** and **RAM** info of them, you should add your servers by menu  **IPTV Moinitor->Monitor Configuration->Monitored Servers** first. And the streams also need to be imported to db by yourself(**IPTV Moinitor->Monitor Configuration->Monitored Streams**). Then, you should deploy [IPTVAgent](https://github.com/AlexanderJLiu/IPTVAgent) which can upload the realtime info to db on your server, and use [IPTVStreaming](https://github.com/AlexanderJLiu/IPTVStreaming) to stream your sources.

## Screenshots
* **Login page**

![login](https://raw.githubusercontent.com/AlexanderJLiu/IPTVM/master/raw/images/login.png)

---

* **Monitor Dashboard**

![monitor_dashboard](https://raw.githubusercontent.com/AlexanderJLiu/IPTVM/master/raw/images/monitor_dashboard.png)

---

* **Server List**

![server_list](https://raw.githubusercontent.com/AlexanderJLiu/IPTVM/master/raw/images/server_list.png)

---

* **Server Comparasion**

![server_comparasion](https://raw.githubusercontent.com/AlexanderJLiu/IPTVM/master/raw/images/server_comparasion.png)

---

* **Server Details**

![server_detail](https://raw.githubusercontent.com/AlexanderJLiu/IPTVM/master/raw/images/server_detail.png)

---

* **Server CPU History**

![server_cpu_history](https://raw.githubusercontent.com/AlexanderJLiu/IPTVM/master/raw/images/server_cpu_history.png)

---

* **Server RAM History**

![server_ram_history](https://raw.githubusercontent.com/AlexanderJLiu/IPTVM/master/raw/images/server_ram_history.png)

---

* **Server Load History**

![server_load_history](https://raw.githubusercontent.com/AlexanderJLiu/IPTVM/master/raw/images/server_load_history.png)

---

* **Stream Monitor**

![stream_monitor](https://raw.githubusercontent.com/AlexanderJLiu/IPTVM/master/raw/images/stream_monitor.png)

---

* **Stream Comparasion**

![stream_comparasion](https://raw.githubusercontent.com/AlexanderJLiu/IPTVM/master/raw/images/stream_comparasion.png)

---

* **Stream Play**

![stream_play](https://raw.githubusercontent.com/AlexanderJLiu/IPTVM/master/raw/images/stream_play.png)

---

* **Management Home**

![management_home](https://raw.githubusercontent.com/AlexanderJLiu/IPTVM/master/raw/images/management_home.png)

---

* **Account Management**

![account_management](https://raw.githubusercontent.com/AlexanderJLiu/IPTVM/master/raw/images/account_management.png)

---

* **Menu Management**

![menu_management](https://raw.githubusercontent.com/AlexanderJLiu/IPTVM/master/raw/images/menu_management.png)

---

* **Timezone Management**

![timezone_management](https://raw.githubusercontent.com/AlexanderJLiu/IPTVM/master/raw/images/timezone_management.png)

---

## Note

if you stream youself using nginx, for playing hls file on this system, you should configure your nginx server :
	
	server ## For Serving HLS Segments
	{
		listen 80;
		server_name localhost;
		add_header Access-Control-Allow-Origin *;
		...
	}