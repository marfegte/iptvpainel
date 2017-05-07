#IPTV Content Management System

* for play hls file , you should configure your nginx server
	server ## For Serving HLS Segments
	{
		listen 80;
		server_name localhost;
		add_header Access-Control-Allow-Origin *;
		...
	}