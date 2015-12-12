import React from "react";

export default class ArticleRow extends React.Component {
  render() {
    return (
      <tr className="status">
        <td id={this.props.article.id}>{this.props.article.title}</td>
        <td>{this.props.article.url}</td>
        <td>{this.props.article.category}</td>
      </tr>
    );
  }
}
