# The Reader

## Start in development
    docker-compose up -d

## Deploy
    ./deploy.sh

TODO
----
* Easy
  * Add searching to article list
  * "read" option when creating article, if already read
  * Get rid of history crap in url bar
  * Cleanup articles (remove articles giving 404, and keep stats on what was removed)
  * Stats: CRUD logs of articles; GenEvent to save to DB
    * Number of articles, read, favorited, etc.
* Hard
  * Button to parse newsletter emails from Gmail and list the articles for  
    manual approval. Gmail API. Even better would be for Gmail to send an post
    to the app's API automatically. 
  * Content parser app to specify things like:
    * read time, based on number of words
    * top 3 most used words
  * Pick a category and word(s) and search the content of all articles in category
    * Whew!
* Maybe TODO
  * Add front end tests
  * Make site mobile friendly

ERRORS
--
* Handle Random article with no article returned from query (nil.id function)

TEST
--
* Fix failures for updating stale struct
* Intermittent failures on title updating due to using real network requests
* api_test container needs "wait for db" process upon initial container creation

