<?php
namespace app\models;
/**
 * 定义Command常量
 */
class Command{
    // actions
    const REQUEST = 0;
    const RESPONSE = 1;
    
    // iptvstreaming
    const STOP_IPTVSTREAMING = 1;
    const START_IPTVSTREAMING = 2;
    const RESTART_IPTVSTREAMING = 3;
    
    // stream
    const STOP_STREAM = 4;
    const START_STREAM = 5;
    const RESTART_STREAM = 6;
    
    // mysql
    const STOP_MYSQL = 7;
    const START_MYSQL = 8;
    const RESTART_MYSQL = 9;
    
    // nginx
    const STOP_NGINX = 10;
    const START_NGINX = 11;
    const RESTART_NGINX = 12;
    
    // quit
    const QUIT = 13;
}