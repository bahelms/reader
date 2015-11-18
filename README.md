# The Reader

Heroku URL: [fathomless-island-3495.herokuapp.com](https://fathomless-island-3495.herokuapp.com)

## Start in development
From /front_end:  

    npm start

From /:  

    mix phoenix.server

TODO
----
* Add not null constraint to url, category on articles
* Bulk article creation as parallel task
* Create article groups with ordered articles
* Stats: CRUD logs of articles; GenEvent to save to DB

ERRORS
----  
* Sometimes upon title retrieval:  
    2015-10-22T10:59:10.264687+00:00 app[web.1]: Function: &Reader.ArticleWorker.fetch_title/1
    2015-10-22T10:59:10.264689+00:00 app[web.1]:     Args: [%Reader.Article{__meta__: #Ecto.Schema.Metadata<:loaded>, category: "react", favorite: false, id: 233, inserted_at: #Ecto.DateTime<2015-10-22T10:59:09Z>, read: false, title: nil, updated_at: #Ecto.DateTime<2015-10-22T10:59:09Z>, url: "http://hugogiraudel.com/2015/06/18/styling-react-components-in-sass/"}]
    2015-10-22T10:59:10.264689+00:00 app[web.1]: ** (exit) an exception was raised:
    2015-10-22T10:59:10.264690+00:00 app[web.1]:     ** (MatchError) no match of right hand side value: []
    2015-10-22T10:59:10.264691+00:00 app[web.1]:         (reader) lib/reader/article_worker.ex:12: Reader.ArticleWorker.fetch_title/1
    2015-10-22T10:59:10.264692+00:00 app[web.1]:         (elixir) lib/task/supervised.ex:74: Task.Supervised.do_apply/2
    2015-10-22T10:59:10.264692+00:00 app[web.1]:         (stdlib) proc_lib.erl:237: :proc_lib.init_p_do_apply/3
* Titles returned are also "301 redirect" strings
* When URL has been taken for Bulk Articles, server error instead of flash warning


