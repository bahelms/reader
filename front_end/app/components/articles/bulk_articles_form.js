import React from "react";
import FlashMessage from "../layout/flash"

export default class BulkArticlesForm extends React.Component {
  constructor(props) {
    super(props);
    this.defaultState = {articles: "", category: "", flash: null};
    this.state = this.defaultState;
  }

  handleCreateArticles(event) {
    event.preventDefault();
    if (this.formIsValid())
      this.props.server.postBulkArticles({
        category: this.refs.category.value,
        articles: this.refs.articles.value
      }, this.handlePostResponse.bind(this));
  }

  handlePostResponse(data) {
    console.log(data);
  }

  handleCategoryInput(event) { this.setState({category: event.target.value}); }
  handleArticlesInput(event) { this.setState({articles: event.target.value}); }

  formIsValid() {
    if (this.refs.articles.value == "") {
      this.setState(this.setFlash("danger", "Article URLs can't be blank"));
      return false;
    }
    if (this.refs.category.value == "") {
      this.setState(this.setFlash("danger", "Category can't be blank"));
      return false;
    }
    return true;
  }

  setFlash(alert, message) {
    return {flash: {alert: alert, message: message}};
  }

  showFlash() {
    if (this.state.flash) return <FlashMessage flash={this.state.flash} />;
  }

  render() {
    return(
      <div id="bulk_articles_form">
        {this.showFlash()}

        <div className="row">
          <div className="col-md-4 col-md-offset-2">
            <h2>Add bulk articles</h2>
            <small>Urls separated by newlines</small>
          </div>
        </div>

        <form className="form-inline">
          <div className="row">
            <div className="col-md-7 col-md-offset-2">
              <div className="form-group">
                <textarea ref="articles" name="articles" className="form-control"
                  rows="12" cols="100" value={this.state.articles}
                  onChange={this.handleArticlesInput.bind(this)} />
              </div>
            </div>
            <div className="col-md-2">
              <div className="form-group">
                <input type="text" ref="category" name="category"
                  className="form-control" placeholder="Category"
                  value={this.state.category}
                  onChange={this.handleCategoryInput.bind(this)} />
              </div>
              <div className="form-group">
                <button className="btn"
                  onClick={this.handleCreateArticles.bind(this)}>
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
