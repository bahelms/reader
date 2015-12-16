import React from "react";
import Data from "../../utils/data";

export default class Article extends React.Component {
  constructor(props) {
    super(props);
    this.state = {article: {}};
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

  render() {
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
            <a href={this.state.article.url} target="_blank">{this.state.article.url}</a>
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
          <div className="col-md-7">{this.displayBoolean(this.state.article.read)}</div>
        </div>
        <div className="row">
          <div className="col-md-1 col-md-offset-4 text-right">
            <strong>Favorite:</strong>
          </div>
          <div className="col-md-7">{this.displayBoolean(this.state.article.favorite)}</div>
        </div>
      </div>
    );

//       <div class="row" id="edit_article_buttons">
//         <div class="col-md-4 col-md-offset-4">
//           <%= status_button(:favorite, @conn, @article) %>
//           <%= status_button(:read, @conn, @article) %>
//           <%= link "Edit", to: article_path(@conn, :edit, @article),
//             class: "btn btn-warning" %>
//         </div>
//         <div class="col-md-1 pull-right">
//           <%= button "Delete", to: article_path(@conn, :delete, @article),
//             method: "delete", class: "btn btn-danger", "data-behavior": "confirm" %>
//         </div>
//       </div>
  }
}
