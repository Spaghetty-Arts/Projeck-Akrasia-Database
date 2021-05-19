CREATE TABLE user (
	id	 int AUTO_INCREMENT,
	username varchar(20) UNIQUE NOT NULL,
	password varchar(60) NOT NULL,
	email	 varchar(60) UNIQUE NOT NULL,
	PRIMARY KEY(id)
);

CREATE TABLE reset (
	id	 int AUTO_INCREMENT,
	email	 varchar(60) UNIQUE NOT NULL,
	token	 varchar(60) UNIQUE NOT NULL,
	user_id int NOT NULL,
	PRIMARY KEY(id)
);

ALTER TABLE reset ADD CONSTRAINT reset_fk1 FOREIGN KEY (user_id) REFERENCES user(id);

DROP EVENT IF EXISTS `delete_old_request`;
CREATE EVENT `delete_old_request`  ON SCHEDULE EVERY 12 hour
STARTS '2010-01-01 00:00:00'
DO
DELETE FROM `reset` where DATEDIFF(now(),`request_date`) > 1;

ALTER EVENT `delete_old_request` ON  COMPLETION PRESERVE ENABLE;