-- 
-- Created by SQL::Translator::Producer::SQLite
-- Created on Sun Feb 17 10:17:59 2013
-- 

;
BEGIN TRANSACTION;
--
-- Table: category
--
CREATE TABLE category (
  id  NOT NULL,
  name  NOT NULL,
  PRIMARY KEY (id)
);
--
-- Table: data
--
CREATE TABLE data (
  id  NOT NULL,
  name  NOT NULL,
  data  NOT NULL,
  PRIMARY KEY (id)
);
CREATE UNIQUE INDEX data_name_unique ON data (name);
--
-- Table: user
--
CREATE TABLE user (
  id  NOT NULL,
  PRIMARY KEY (id)
);
--
-- Table: feed
--
CREATE TABLE feed (
  id  NOT NULL,
  submitting_user  NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (submitting_user) REFERENCES user(id)
);
CREATE INDEX feed_idx_submitting_user ON feed (submitting_user);
--
-- Table: article
--
CREATE TABLE article (
  id  NOT NULL,
  source_feed ,
  submitting_user  NOT NULL,
  category  NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (category) REFERENCES category(id),
  FOREIGN KEY (source_feed) REFERENCES feed(id),
  FOREIGN KEY (submitting_user) REFERENCES user(id)
);
CREATE INDEX article_idx_category ON article (category);
CREATE INDEX article_idx_source_feed ON article (source_feed);
CREATE INDEX article_idx_submitting_user ON article (submitting_user);
--
-- Table: vote
--
CREATE TABLE vote (
  id  NOT NULL,
  article_id  NOT NULL,
  user_id  NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (article_id) REFERENCES article(id),
  FOREIGN KEY (user_id) REFERENCES user(id)
);
CREATE INDEX vote_idx_article_id ON vote (article_id);
CREATE INDEX vote_idx_user_id ON vote (user_id);
CREATE UNIQUE INDEX vote_combo_unique ON vote (article_id, user_id);
COMMIT;
