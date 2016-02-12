import React from "react";
import { Link } from "react-router";

export default class ArticleRow extends React.Component {
  setStatus(article) {
    if (article.favorite)
      return "success";
    else if (article.read)
      return "info";
    else
      return "";
  }

  titleLinkStyle() {
    return {
      textDecoration: "none",
      color: "black"
    };
  }

  render() {
    return (
      <tr className={this.setStatus(this.props.article)}>
        <td>
          <Link to={`/articles/${this.props.article.id}`}
            style={this.titleLinkStyle()}>
            {this.props.article.title}
          </Link>
        </td>
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
