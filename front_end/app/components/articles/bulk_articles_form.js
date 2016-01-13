import React from "react";

export default class BulkArticlesForm extends React.Component {
  render() {
    return(
      <div id="bulk_articles_form">
        <div className="row">
          <div className="col-md-4 col-md-offset-2">
            <h2>Add bulk articles</h2>
            <small>Urls separated by newlines</small>
          </div>
        </div>

        <form className="form-inline">
          <div className="row">
            <div className="col-md-7 col-md-offset-2">
              <div className="form-group">
                <textarea name="bulk_articles" className="form-control"
                  rows="12" cols="100" />
              </div>
            </div>
            <div className="col-md-2">
              <div className="form-group">
                <input type="text" name="category" className="form-control"
                  placeholder="Category" />
              </div>
              <div className="form-group">
                <button className="btn">Submit</button>
              </div>
            </div>
          </div>
        </form>
      </div>
    );
  }
}
