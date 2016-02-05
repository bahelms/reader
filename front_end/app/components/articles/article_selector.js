import React from "react";
import Server from "../../utils/server";

export default class ArticleSelector extends React.Component {
  constructor(props) {
    super(props);
    this.state = {categories: []};
    this.server = new Server();
  }

  componentDidMount() {
    this.server.getArticleCategories((categories) => {
      this.setState({categories: categories});
    });
  }

  articleBtnStyle() {
   return { margin: "1.875em 0 0 0.8em" };
  }

  displayCategories() {
    return this.state.categories.map((category, index) => {
      return <option key={index} value={category}>{category}</option>;
    });
  }

  getArticle() {
    alert("Not implemented yet!");
  }

  render() {
    return (
      <div id="article_selector">
        <div className="row">
          <div className="col-md-12 text-center">
            <h2>Select a category</h2>
          </div>
          <div className="row">
            <div className="col-md-2 col-md-offset-5">
              <select className="form-control">
                {this.displayCategories()}
              </select>
            </div>
          </div>
        </div>

        <div className="row">
          <div className="col-md-2 col-md-offset-5">
            <button className="btn btn-lg btn-primary"
              style={this.articleBtnStyle()}
              onClick={this.getArticle}>
              Get me an article!
            </button>
          </div>
        </div>
      </div>
    );
  }
}

