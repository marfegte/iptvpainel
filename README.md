# IPTV Content Management System

## Introduction

**IPTVM** is short for IPTV Content Management System based on **yii** framework, which not only can manage basic IPTV information of Set-Top Box including accounts, products, etc. , but also can monitor and control the  remote servers where streams deployed on it. 

## Screenshots
* Login page

![login](https://github.com/AlexanderJLiu/IPTVM/blob/master/raw/master/images/login.png)

## Note
if you stream youself using nginx, for playing hls file on this system, you should configure your nginx server :
	server ## For Serving HLS Segments
	{
		listen 80;
		server_name localhost;
		add_header Access-Control-Allow-Origin *;
		...
	}
