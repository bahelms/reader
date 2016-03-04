# The Reader

## Start in development
    docker-compose up -d

## Deploy
Coming soon...

TODO
----
* Display date article was added
* Trim url of ?utm_source... crap upon creation
* Add sorting and searching to article list
* "read" option when creating article, if already read
* CSS: center article page
* Content parser app to specify things like:
  * read time, based on number of words
  * top 3 most used words
* Stats: CRUD logs of articles; GenEvent to save to DB
  * Number of articles, read, favorited, etc.
* Cleanup articles (remove articles giving 404, and keep stats on what was removed)

ERRORS
* Handle Random article with no article returned from query (nil.id function)
* First test run in new containers has failures; all following tests pass

