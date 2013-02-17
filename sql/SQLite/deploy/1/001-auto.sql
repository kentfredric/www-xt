-- 
-- Created by SQL::Translator::Producer::SQLite
-- Created on Sun Feb 17 13:20:57 2013
-- 

;
BEGIN TRANSACTION;
--
-- Table: category
--
CREATE TABLE category (
  id INTEGER PRIMARY KEY NOT NULL,
  name text NOT NULL
);
--
-- Table: data
--
CREATE TABLE data (
  id INTEGER PRIMARY KEY NOT NULL,
  name text NOT NULL,
  data text NOT NULL
);
CREATE UNIQUE INDEX data_name_unique ON data (name);
--
-- Table: user
--
CREATE TABLE user (
  id INTEGER PRIMARY KEY NOT NULL
);
--
-- Table: feed
--
CREATE TABLE feed (
  id INTEGER PRIMARY KEY NOT NULL,
  submitting_user int NOT NULL,
  FOREIGN KEY (submitting_user) REFERENCES user(id)
);
CREATE INDEX feed_idx_submitting_user ON feed (submitting_user);
--
-- Table: article
--
CREATE TABLE article (
  id INTEGER PRIMARY KEY NOT NULL,
  source_feed int,
  submitting_user int NOT NULL,
  category int NOT NULL,
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
  id INTEGER PRIMARY KEY NOT NULL,
  article_id int NOT NULL,
  user_id int NOT NULL,
  FOREIGN KEY (article_id) REFERENCES article(id),
  FOREIGN KEY (user_id) REFERENCES user(id)
);
CREATE INDEX vote_idx_article_id ON vote (article_id);
CREATE INDEX vote_idx_user_id ON vote (user_id);
CREATE UNIQUE INDEX vote_combo_unique ON vote (article_id, user_id);
COMMIT;
