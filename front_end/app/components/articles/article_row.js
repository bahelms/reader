import React from "react";

export default class ArticleRow extends React.Component {
  setStatus(article) {
    if (article.favorite)
      return "success";
    else if (article.read)
      return "info";
    else
      return "";
  }

  render() {
    return (
      <tr className={this.setStatus(this.props.article)}>
        <td id={this.props.article.id}>{this.props.article.title}</td>
        <td>
          <a href={this.props.article.url} target="_blank">
            {this.props.article.url}
          </a>
        </td>
        <td>{this.props.article.category}</td>
      </tr>
    );
  }
}
