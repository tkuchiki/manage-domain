CREATE DATABASE IF NOT EXISTS `mng_domain` CHARACTER SET utf8;

DROP TABLE IF EXISTS `mng_domain`.`domain_list`;

CREATE TABLE `mng_domain`.`domain_list` (
  `id`          INT(11)       UNSIGNED NOT NULL AUTO_INCREMENT,
  `record_type` TINYINT(4)    UNSIGNED NOT NULL,
  `https`       TINYINT(4)    UNSIGNED default 0,
  `domain`      VARCHAR(1024)          NOT NULL,
  `sub_domain`  VARCHAR(1024),
  `ip`          VARCHAR(1024)          NOT NULL,
  PRIMARY KEY (`id`)
);