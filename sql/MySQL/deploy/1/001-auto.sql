-- 
-- Created by SQL::Translator::Producer::MySQL
-- Created on Sun Feb 17 10:17:59 2013
-- 
;
SET foreign_key_checks=0;
--
-- Table: `category`
--
CREATE TABLE `category` (
  `id`  NOT NULL auto_increment,
  `name`  NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;
--
-- Table: `data`
--
CREATE TABLE `data` (
  `id`  NOT NULL auto_increment,
  `name`  NOT NULL,
  `data`  NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE `data_name_unique` (`name`)
);
--
-- Table: `user`
--
CREATE TABLE `user` (
  `id`  NOT NULL auto_increment,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;
--
-- Table: `feed`
--
CREATE TABLE `feed` (
  `id`  NOT NULL auto_increment,
  `submitting_user`  NOT NULL,
  INDEX `feed_idx_submitting_user` (`submitting_user`),
  PRIMARY KEY (`id`),
  CONSTRAINT `feed_fk_submitting_user` FOREIGN KEY (`submitting_user`) REFERENCES `user` (`id`)
) ENGINE=InnoDB;
--
-- Table: `article`
--
CREATE TABLE `article` (
  `id`  NOT NULL auto_increment,
  `source_feed`  NULL,
  `submitting_user`  NOT NULL,
  `category`  NOT NULL,
  INDEX `article_idx_category` (`category`),
  INDEX `article_idx_source_feed` (`source_feed`),
  INDEX `article_idx_submitting_user` (`submitting_user`),
  PRIMARY KEY (`id`),
  CONSTRAINT `article_fk_category` FOREIGN KEY (`category`) REFERENCES `category` (`id`),
  CONSTRAINT `article_fk_source_feed` FOREIGN KEY (`source_feed`) REFERENCES `feed` (`id`),
  CONSTRAINT `article_fk_submitting_user` FOREIGN KEY (`submitting_user`) REFERENCES `user` (`id`)
) ENGINE=InnoDB;
--
-- Table: `vote`
--
CREATE TABLE `vote` (
  `id`  NOT NULL auto_increment,
  `article_id`  NOT NULL,
  `user_id`  NOT NULL,
  INDEX `vote_idx_article_id` (`article_id`),
  INDEX `vote_idx_user_id` (`user_id`),
  PRIMARY KEY (`id`),
  UNIQUE `vote_combo_unique` (`article_id`, `user_id`),
  CONSTRAINT `vote_fk_article_id` FOREIGN KEY (`article_id`) REFERENCES `article` (`id`),
  CONSTRAINT `vote_fk_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB;
SET foreign_key_checks=1;
