import React from "react";
import Server from "../../server";
import ArticleRow from "./article_row";

export default class ArticlesTable extends React.Component {
  constructor(props) {
    super(props);
    this.state = {articles: []};
  }

  componentDidMount() {
    $.get(`${Server.address()}/articles`, (articles) => {
      this.setState({articles: articles});
    });
  }

  render() {
    return (
      <div classNameName="row">
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
              {this.state.articles.map((article, index) => {
                return <ArticleRow article={article} key={index} />;
              })}
            </tbody>
          </table>
        </div>
      </div>
    );
  }
}

