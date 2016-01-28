import React from "react";

export default class SingleArticleForm extends React.Component {
  handleCreateArticle(event) {
    event.preventDefault();
    this.props.server.postArticle({
      type: "create_article",
      article: {
        title: this.refs.title.value,
        url: this.refs.url.value,
        category: this.refs.category.value
      }
    }, this.handlePostResponse)
  }

  handlePostResponse(data) {
    console.log(data);
    // update flash
    // clear inputs
  }

  render() {
    return(
      <div id="single_article_form">
        <div className="row">
          <div className="col-md-2 col-md-offset-2">
            <h2>Add article</h2>
          </div>
        </div>

        <form className="form-inline">
          <div className="row">
            <div className="col-md-8 col-md-offset-2">
              <div className="form-group">
                <input type="text" name="url" className="form-control" ref="url"
                  placeholder="URL" />
              </div>
              <div className="form-group">
                <input type="text" name="category" className="form-control"
                  ref="category" placeholder="Category" />
              </div>
              <div className="form-group">
                <input type="text" name="title" className="form-control"
                  ref="title" placeholder="Title" />
              </div>
              <div className="form-group">
                <button className="btn"
                  onClick={this.handleCreateArticle.bind(this)}>
                  Submit
                </button>
              </div>
            </div>
          </div>
        </form>
      </div>
    );
  }
}
