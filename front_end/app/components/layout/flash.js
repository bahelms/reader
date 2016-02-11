import React from "react";

export default class FlashMessage extends React.Component {
  formatMessage() {
    let message = this.props.flash.message;
    if (Array.isArray(message))
      return(
        <ul>
          {message.map((error, i) => { return <li key={i}>{error}</li>; })}
        </ul>
      );
    else
      return message;
  }

  render() {
    return(
      <div className="row">
        <div className={`alert alert-${this.props.flash.alert} col-md-8 col-md-offset-2`}>
          {this.formatMessage()}
        </div>
      </div>
    );
  }
}

