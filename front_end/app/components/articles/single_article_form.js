import React from "react";

export default class SingleArticleForm extends React.Component {
  constructor(props) {
    super(props);
    this.defaultState = {url: "", category: "", title: ""};
    this.state = this.defaultState;
  }

  handleCreateArticle(event) {
    event.preventDefault();
    this.props.server.postArticle({
      type: "create_article",
      article: {
        title: this.refs.title.value,
        url: this.refs.url.value,
        category: this.refs.category.value
      }
    }, this.handlePostResponse.bind(this))
  }

  handlePostResponse(data) {
    console.log(data);
    if (data.status == "ok")
      this.setState(this.defaultState);
    else {
      // set flash
    }
  }

  handleURLInput(event) { this.setState({url: event.target.value}); }
  handleTitleInput(event) { this.setState({title: event.target.value}); }
  handleCategoryInput(event) { this.setState({category: event.target.value}); }

  showFlash() {
    return(
      <div className="row">
        <div className={`alert alert-${'danger'} col-md-8 col-md-offset-2`}>
        </div>
      </div>
    );
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
                  placeholder="URL" value={this.state.url}
                  onChange={this.handleURLInput.bind(this)} />
              </div>
              <div className="form-group">
                <input type="text" name="category" className="form-control"
                  ref="category" placeholder="Category"
                  value={this.state.category}
                  onChange={this.handleCategoryInput.bind(this)} />
              </div>
              <div className="form-group">
                <input type="text" name="title" className="form-control"
                  ref="title" placeholder="Title" value={this.state.title}
                  onChange={this.handleTitleInput.bind(this)} />
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
