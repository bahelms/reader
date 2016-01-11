import React from "react";

export default class ArticleEditErrors extends React.Component {
  capitalize(string) {
    return string.charAt(0).toUpperCase() + string.slice(1);
  }

  render() {
    return (
      <div className="container">
        {
          this.props.errors.map((error, i) => {
            return(
              <div className="row" key={i}>
                <span className="col-md-4 col-md-offset-4 alert alert-danger">
                  {this.capitalize(error)}
                </span>
              </div>
            )
          })
        }
      </div>
    );
  }
}

ArticleEditErrors.defaultProps = {errors: []};
