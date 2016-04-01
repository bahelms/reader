import React from "react";

export default class ArticleSort extends React.Component {
  categoryOptions() {
    return this.props.categories.map((category, i) => {
      return <option key={i} value={category}>{category}</option>;
    })
  }

  render() {
    return(
      <div className="row">
        <label className="col-md-2">
          Display By Category:
        </label>
        <div className="col-md-2">
          <select className="form-control" ref="category"
            onChange={this.props.handleCategoryChange}>
            {this.categoryOptions()}
          </select>
        </div>
      </div>
    );
  }
}
