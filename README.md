# IPTV Content Management System

## Introduction

**IPTVM** is short for IPTV Content Management System based on **yii** framework, which not only can manage basic IPTV information of Set-Top Box including accounts, products, etc. , but also can monitor and control the  remote servers where streams deployed on. 

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