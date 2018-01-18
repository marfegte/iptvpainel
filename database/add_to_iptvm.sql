### header to add
drop database if exists iptvm;
create database iptvm default character set utf8 collate utf8_general_ci;
use iptvm;

.......
.......

### footer to add(trigger and scheduler event)


# trigger
DROP TRIGGER IF EXISTS `insertApp`;
DELIMITER $$
CREATE TRIGGER `insertApp` 
AFTER INSERT ON `server` 
FOR EACH ROW 
BEGIN
insert into mysql values (0, new.serverName );
insert into nginx values (0, new.serverName );
END
$$
DELIMITER ;

# scheduler event
SET GLOBAL event_scheduler = 1;
DROP EVENT IF EXISTS `callUpdateServerProcedure`;
DELIMITER $$
CREATE EVENT `callUpdateServerProcedure` ON SCHEDULE EVERY 1 SECOND STARTS CURRENT_TIMESTAMP ON COMPLETION NOT PRESERVE ENABLE DO CALL updateServerStatus
$$
DELIMITER ;

DROP EVENT IF EXISTS `callUpdateStreamProcedure`;
DELIMITER $$
CREATE EVENT `callUpdateStreamProcedure` ON SCHEDULE EVERY 1 MINUTE STARTS CURRENT_TIMESTAMP ON COMPLETION NOT PRESERVE ENABLE DO CALL updateStreamStatus
$$