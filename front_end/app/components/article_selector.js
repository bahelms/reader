import React from "react";

export default class ArticleSelector extends React.Component {
  constructor(props) {
    super(props);
    this.state = {categories: ["hey", "who", "there", "barf"]};
  }

  articleBtnStyle() {
    return { margin: "30px 0 0 110px" };
  }

  displayCategories() {
    return this.state.categories.map((category) => {
      return <option value={category}>{category}</option>;
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
                { this.displayCategories() }
              </select>
            </div>
          </div>
        </div>

        <div className="row">
          <div className="col-md-2 col-md-offset-4">
            <button className="btn btn-lg btn-primary" style={this.articleBtnStyle()}
              onClick={this.getArticle}>
              Get me an article!
            </button>
          </div>
        </div>
      </div>
    );
  }
}

