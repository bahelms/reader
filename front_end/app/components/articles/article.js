import React from "react";
import Data from "../../utils/data";
import ArticleControlButtons from "./article_control_buttons";

export default class Article extends React.Component {
  constructor(props) {
    super(props);
    this.state = {article: {}, edit: false};
    this.data = new Data();
  }

  componentDidMount() {
    this.data.getArticle(this.props.params.id, (article) => {
      this.setState({article: article});
    });
  }

  displayBoolean(value) {
    return (value) ? "true" : "false";
  }

  handleToggleEdit() {
    this.setState({edit: !this.state.edit});
  }

  handleSaveArticle() {
    let params = {
      article: {
        title: this.refs.articleTitle.value,
        url: this.refs.articleUrl.value,
        category: this.refs.articleCategory.value
      }
    };

    this.data.putArticle(this.props.params.id, params, (response) => {
      if (response.status == "ok")
        this.setState({article: response.article, edit: false});
      else if (response.status == "error")
        // Display form errors
        console.log(response.errors);
    });
  }

  handleToggleRead() {
    let params = {article: {read: true}};

    this.data.putArticle(this.props.params.id, params, (response) => {
      if (response.status == "ok")
        this.setState({article: response.article});
      else if (response.status == "error")
        // Display form errors
        console.log(response.errors);
    });
  }

  showArticle() {
    return(
      <div className="row">
        <div className="row">
          <div className="col-md-1 col-md-offset-4 text-right">
            <strong>Title:</strong>
          </div>
          <div className="col-md-7">{this.state.article.title}</div>
        </div>
        <div className="row">
          <div className="col-md-1 col-md-offset-4 text-right">
            <strong>URL:</strong>
          </div>
          <div className="col-md-7">
            <a href={this.state.article.url} target="_blank">
              {this.state.article.url}
            </a>
          </div>
        </div>
        <div className="row">
          <div className="col-md-1 col-md-offset-4 text-right">
            <strong>Category:</strong>
          </div>
          <div className="col-md-7">{this.state.article.category}</div>
        </div>
        <div className="row">
          <div className="col-md-1 col-md-offset-4 text-right">
            <strong>Read:</strong>
          </div>
          <div className="col-md-7">
            {this.displayBoolean(this.state.article.read)}
          </div>
        </div>
        <div className="row">
          <div className="col-md-1 col-md-offset-4 text-right">
            <strong>Favorite:</strong>
          </div>
          <div className="col-md-7">
            {this.displayBoolean(this.state.article.favorite)}
          </div>
        </div>
        <ArticleControlButtons
          isEdit={false}
          article={this.state.article}
          editArticle={this.handleToggleEdit.bind(this)}
          readArticle={this.handleToggleRead.bind(this)} />
      </div>
    );
  }

  editArticle() {
    return(
      <div className="row">
        <div className="row">
          <div className="col-md-1 col-md-offset-4 text-right">
            <strong>Title:</strong>
          </div>
          <div className="col-md-4">
            <input type="text" className="form-control" ref="articleTitle"
              defaultValue={this.state.article.title} />
          </div>
        </div>
        <div className="row">
          <div className="col-md-1 col-md-offset-4 text-right">
            <strong>URL:</strong>
          </div>
          <div className="col-md-4">
            <input type="text" className="form-control" ref="articleUrl"
              defaultValue={this.state.article.url} />
          </div>
        </div>
        <div className="row">
          <div className="col-md-1 col-md-offset-4 text-right">
            <strong>Category:</strong>
          </div>
          <div className="col-md-4">
            <input type="text" className="form-control" ref="articleCategory"
              defaultValue={this.state.article.category} />
          </div>
        </div>
        <div className="row">
          <div className="col-md-1 col-md-offset-4 text-right">
            <strong>Read:</strong>
          </div>
          <div className="col-md-7">
            {this.displayBoolean(this.state.article.read)}
          </div>
        </div>
        <div className="row">
          <div className="col-md-1 col-md-offset-4 text-right">
            <strong>Favorite:</strong>
          </div>
          <div className="col-md-7">
            {this.displayBoolean(this.state.article.favorite)}
          </div>
        </div>
        <ArticleControlButtons
          isEdit={true}
          saveArticle={this.handleSaveArticle.bind(this)}
          cancelEdit={this.handleToggleEdit.bind(this)} />
      </div>
    );
  }

  render() {
    if (this.state.edit)
      return this.editArticle();
    else
      return this.showArticle();
  }
}
