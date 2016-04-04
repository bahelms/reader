# The Reader

## Start in development
    docker-compose up -d

## Deploy
    ./deploy.sh

TODO
----
* Add searching to article list
* "read" option when creating article, if already read
* Add front end tests
* Make site mobile friendly
* Content parser app to specify things like:
  * read time, based on number of words
  * top 3 most used words
* Pick a category and word(s) and search the content of all articles in category
  * Whew!
* Stats: CRUD logs of articles; GenEvent to save to DB
  * Number of articles, read, favorited, etc.
* Cleanup articles (remove articles giving 404, and keep stats on what was removed)

ERRORS
--
* Handle Random article with no article returned from query (nil.id function)

TEST
--
* Fix failures for updating stale struct
* Intermittent failures on title updating due to using real network requests

