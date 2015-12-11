import React from "react";
import Server from "../../server";

export default class ArticlesTable extends React.Component {
  constructor(props) {
    super(props);
    this.state = {articles: []};
  }

  componentDidMount() {
    $.get(`${Server.address()}/articles`, (data) => {
      this.setState({articles: data.articles});
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
                return (
                  <tr className="info" key={index}>
                    <td id={article.id}>{article.title}</td>
                    <td>{article.url}</td>
                    <td>{article.category}</td>
                  </tr>
                );
              })}
            </tbody>
          </table>
        </div>
      </div>
    );
  }
}

