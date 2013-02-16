-- 
-- Created by SQL::Translator::Producer::PostgreSQL
-- Created on Sun Feb 17 10:17:59 2013
-- 
;
--
-- Table: category.
--
CREATE TABLE "category" (
  "id" serial NOT NULL,
  "name"  NOT NULL,
  PRIMARY KEY ("id")
);

;
--
-- Table: data.
--
CREATE TABLE "data" (
  "id" serial NOT NULL,
  "name"  NOT NULL,
  "data"  NOT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "data_name_unique" UNIQUE ("name")
);

;
--
-- Table: user.
--
CREATE TABLE "user" (
  "id" serial NOT NULL,
  PRIMARY KEY ("id")
);

;
--
-- Table: feed.
--
CREATE TABLE "feed" (
  "id" serial NOT NULL,
  "submitting_user"  NOT NULL,
  PRIMARY KEY ("id")
);
CREATE INDEX "feed_idx_submitting_user" on "feed" ("submitting_user");

;
--
-- Table: article.
--
CREATE TABLE "article" (
  "id" serial NOT NULL,
  "source_feed" ,
  "submitting_user"  NOT NULL,
  "category"  NOT NULL,
  PRIMARY KEY ("id")
);
CREATE INDEX "article_idx_category" on "article" ("category");
CREATE INDEX "article_idx_source_feed" on "article" ("source_feed");
CREATE INDEX "article_idx_submitting_user" on "article" ("submitting_user");

;
--
-- Table: vote.
--
CREATE TABLE "vote" (
  "id" serial NOT NULL,
  "article_id"  NOT NULL,
  "user_id"  NOT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "vote_combo_unique" UNIQUE ("article_id", "user_id")
);
CREATE INDEX "vote_idx_article_id" on "vote" ("article_id");
CREATE INDEX "vote_idx_user_id" on "vote" ("user_id");

;
--
-- Foreign Key Definitions
--

;
ALTER TABLE "feed" ADD CONSTRAINT "feed_fk_submitting_user" FOREIGN KEY ("submitting_user")
  REFERENCES "user" ("id") DEFERRABLE;

;
ALTER TABLE "article" ADD CONSTRAINT "article_fk_category" FOREIGN KEY ("category")
  REFERENCES "category" ("id") DEFERRABLE;

;
ALTER TABLE "article" ADD CONSTRAINT "article_fk_source_feed" FOREIGN KEY ("source_feed")
  REFERENCES "feed" ("id") DEFERRABLE;

;
ALTER TABLE "article" ADD CONSTRAINT "article_fk_submitting_user" FOREIGN KEY ("submitting_user")
  REFERENCES "user" ("id") DEFERRABLE;

;
ALTER TABLE "vote" ADD CONSTRAINT "vote_fk_article_id" FOREIGN KEY ("article_id")
  REFERENCES "article" ("id") DEFERRABLE;

;
ALTER TABLE "vote" ADD CONSTRAINT "vote_fk_user_id" FOREIGN KEY ("user_id")
  REFERENCES "user" ("id") DEFERRABLE;

;
