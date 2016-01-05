import React from "react";

export default class ArticleControlButtons extends React.Component {
  readStatus() {
    return this.props.article.read ? "Unread" : "Read";
  }

  favoriteStatus() {
    return this.props.article.favorite ? "Unfavorite" : "Favorite";
  }

  controlButtons() {
    return(
      <div className="row" id="article_control_buttons">
        <div className="col-md-4 col-md-offset-4">
          <button className="btn btn-info" onClick={this.props.readArticle}>
            {this.readStatus()}
          </button>
          <button className="btn btn-success">{this.favoriteStatus()}</button>
          <button className="btn btn-warning" onClick={this.props.editArticle}>
            Edit
          </button>
        </div>
        <div className="col-md-1 pull-right">
          <button className="btn btn-danger">Delete</button>
        </div>
      </div>
    );
  }

  editButtons() {
    return(
      <div className="row" id="article_control_buttons">
        <div className="col-md-4 col-md-offset-4">
          <button className="btn btn-success" onClick={this.props.saveArticle}>
            Save
          </button>
          <button className="btn btn-danger" onClick={this.props.cancelEdit}>
            Cancel
          </button>
        </div>
      </div>
    );
  }

  render() {
    if (this.props.isEdit)
      return this.editButtons();
    else
      return this.controlButtons();
  }
}
