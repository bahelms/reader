import React from "react";
import Server from "../../utils/server";
import ArticleControlButtons from "./article_control_buttons";
import ArticleNotFound from "./article_not_found";
import ArticleEditErrors from "./article_edit_errors";

class Article extends React.Component {
  constructor(props) {
    super(props);
    this.state = {article: {}, edit: false, articleFound: true};
    this.server = new Server();
  }

  componentDidMount() {
    this.server.getArticle(this.props.params.id, (article) => {
      if (article)
        this.setState({article: article, articleFound: true});
      else
        this.setState({articleFound: false});
    });
  }

  displayBoolean(value) {
    return (value) ? "true" : "false";
  }

  updateArticle(params) {
    this.server.putArticle(this.props.params.id, params, (response) => {
      if (response.status == "ok")
        this.setState({article: response.article, edit: false});
      else if (response.status == "error")
        this.setState({errors: response.errors});
    });
  }

  formattedCreatedDate() {
    const date = new Date(this.state.article.inserted_at || null);
    return date.toLocaleString("en-US", {
      timeZone: "America/New_York",
      timeZoneName: "short"
    });
  }

  handleToggleEdit() {
    this.setState({edit: !this.state.edit, errors: []});
  }

  handleSaveArticle() {
    this.updateArticle({
      article: {
        title: this.refs.articleTitle.value,
        url: this.refs.articleUrl.value,
        category: this.refs.articleCategory.value
      }
    });
  }

  handleDeleteArticle() {
    if (confirm("Are you sure you want to delete this article?")) {
      this.server.deleteArticle(this.props.params.id, (_response) => {
        this.context.history.push("/articles");
      });
    }
  }

  handleToggleRead() {
    this.updateArticle({
      article: {
        read: !this.state.article.read,
        favorite: false
      }
    });
  }

  handleToggleFavorite() {
    this.updateArticle({
      article: {
        favorite: !this.state.article.favorite,
        read: true
      }
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
        <div className="row">
          <div className="col-md-2 col-md-offset-3 text-right">
            <strong>Date Created:</strong>
          </div>
          <div className="col-md-6">{this.formattedCreatedDate()}</div>
        </div>
        <ArticleControlButtons
          isEdit={false}
          article={this.state.article}
          editArticle={this.handleToggleEdit.bind(this)}
          deleteArticle={this.handleDeleteArticle.bind(this)}
          toggleFavoriteStatus={this.handleToggleFavorite.bind(this)}
          toggleReadStatus={this.handleToggleRead.bind(this)} />
      </div>
    );
  }

  editArticle() {
    return(
      <div className="row">
        <ArticleEditErrors errors={this.state.errors} />
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
    if (this.state.articleFound)
      return this.state.edit ? this.editArticle() : this.showArticle();
    else
      return <ArticleNotFound />;
  }
}

Article.contextTypes = { history: React.PropTypes.object.isRequired };

export default Article;
