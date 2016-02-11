import React from "react";
import FlashMessage from "../layout/flash"

export default class SingleArticleForm extends React.Component {
  constructor(props) {
    super(props);
    this.defaultState = {url: "", category: "", title: "", flash: null};
    this.state = this.defaultState;
  }

  handleCreateArticle(event) {
    event.preventDefault();
    this.props.server.postArticle({
      article: {
        title: this.refs.title.value,
        url: this.refs.url.value,
        category: this.refs.category.value
      }
    }, this.handlePostResponse.bind(this));
  }

  handlePostResponse(data) {
    console.log(data);
    if (data.status == "ok")
      this.setState(
        Object.assign(this.defaultState, this.setFlash("info", data.message)));
    else
      this.setState(this.setFlash("danger", data.errors));
  }

  handleURLInput(event)      { this.setState({url: event.target.value}); }
  handleTitleInput(event)    { this.setState({title: event.target.value}); }
  handleCategoryInput(event) { this.setState({category: event.target.value}); }

  setFlash(alert, message) {
    return {flash: {alert: alert, message: message}};
  }

  showFlash() {
    if (this.state.flash)
      return <FlashMessage flash={this.state.flash} />;
  }

  render() {
    return(
      <div id="single_article_form">
        {this.showFlash()}

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
