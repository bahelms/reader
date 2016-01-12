import React from "react";

export default class SingleArticleForm extends React.Component {
  render() {
    return(
      <div>
        <div className="row">
          <div className="col-md-2 col-md-offset-2">
            <h2>Add article</h2>
          </div>
        </div>

        <form className="form-inline" id="articles_form">
          <div className="row">
            <div className="col-md-8 col-md-offset-2">
              <div className="form-group">
                <input type="text" name="url" className="form-control"
                  placeholder="URL" />
              </div>
              <div className="form-group">
                <input type="text" name="category" className="form-control"
                  placeholder="Category" />
              </div>
              <div className="form-group">
                <input type="text" name="title" className="form-control"
                  placeholder="Title" />
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
