import React from "react";
import ArticleRow from "./article_row";

export default class ArticlesTable extends React.Component {
  render() {
    return (
      <div className="row">
        <div className="col-md-12">
          <table className="table table-hover table-condensed">
            <thead>
              <tr>
                <th>Title</th>
                <th>URL</th>
                <th>Category</th>
              </tr>
            </thead>
            <tbody>
              {this.props.articles.map((article, index) => {
                return <ArticleRow article={article} key={index} />;
              })}
            </tbody>
          </table>
        </div>
      </div>
    );
  }
}

