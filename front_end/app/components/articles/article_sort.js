import React from "react";

export default class ArticleSort extends React.Component {
  styles() {
    return {
      sortRow: { marginBottom: "2em" },
      label: { marginTop: "0.5em" }
    };
  }

  categoryOptions() {
    return this.props.categories.map((category, i) => {
      return <option key={i} value={category}>{category}</option>;
    })
  }

  render() {
    return(
      <div className="row" style={this.styles().sortRow}>
        <label className="col-md-2 col-md-offset-3 text-right"
          style={this.styles().label}>
          Display By Category:
        </label>
        <div className="col-md-2">
          <select className="form-control" ref="category"
            value={this.props.sortCategory}
            onChange={this.props.handleCategoryChange}>
            {this.categoryOptions()}
          </select>
        </div>
      </div>
    );
  }
}
