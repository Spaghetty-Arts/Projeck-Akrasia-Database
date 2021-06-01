CREATE TABLE user (
	id	 int AUTO_INCREMENT,
	username varchar(20) UNIQUE NOT NULL,
	password varchar(60) NOT NULL,
	email	 varchar(60) UNIQUE NOT NULL,
	money	 int NOT NULL DEFAULT 100,
	life	 int NOT NULL DEFAULT 100,
	last_login date not null,
	login_reward int not null default 0,
	got_reward tinyint not null default 0,
	active tinyint not null default 0,
	token varchar(60) unique,
	winP int not null  default 0,
	loseP int not null  default 0,
	rankP int not null  default 1,
	last_action timestamp not null,
	PRIMARY KEY(id)
);

CREATE TABLE reset (
	id	 int AUTO_INCREMENT,
	email	 varchar(60) UNIQUE NOT NULL,
	token	 varchar(60) UNIQUE NOT NULL,
	user_id int NOT NULL,
	PRIMARY KEY(id)
);


create table history
(
	id INTEGER auto_increment primary key,
	`match` INTEGER not null,
	winner int not null,
	loser int not null,
	moment timestamp not null
);

ALTER TABLE reset ADD CONSTRAINT reset_fk1 FOREIGN KEY (user_id) REFERENCES user(id);

DROP EVENT IF EXISTS `delete_old_request`;
CREATE EVENT `delete_old_request`  ON SCHEDULE EVERY 12 hour
STARTS '2010-01-01 00:00:00'
DO
DELETE FROM `reset` where DATEDIFF(now(),`request_date`) > 1;


ALTER EVENT `delete_old_request` ON  COMPLETION PRESERVE ENABLE;

DROP EVENT IF EXISTS `delete_old_login`;
CREATE EVENT `delete_old_login`  ON SCHEDULE EVERY 12 hour
STARTS '2010-01-01 00:00:00'
DO
UPDATE user set token = null and active = 0 where active = 1;

ALTER EVENT `delete_old_login` ON  COMPLETION PRESERVE ENABLE;

DROP EVENT IF EXISTS `delete_old_user`;
CREATE EVENT `delete_old_user`  ON SCHEDULE EVERY 1 hour
STARTS '2010-01-01 00:00:00'
DO
UPDATE user set token = null and active = 0 where TIMESTAMPDIFF(HOUR,last_action,NOW()) > 1;

ALTER EVENT `delete_old_user` ON  COMPLETION PRESERVE ENABLE;