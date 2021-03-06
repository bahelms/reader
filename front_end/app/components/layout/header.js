import React from "react";
import { Link } from "react-router";

export default class Header extends React.Component {
  render() {
    return (
      <header>
        <nav className="navbar navbar-inverse navbar-fixed-top">
          <div className="container-fluid">
            <div className="navbar-header">
              <button type="button" className="navbar-toggle collapsed"
                data-toggle="collapse" data-target="#navbar-collapse-1"
                aria-expanded="false">
                <span className="sr-only">Toggle navigation</span>
              </button>
              <a href="/" className="navbar-brand">The Reader</a>
            </div>

            <div className="collapse navbar-collapse" id="navbar-collapse-1">
              <ul className="nav navbar-nav">
                <li><Link to="/articles/new">Add Articles</Link></li>
                <li><Link to="/articles">All Articles</Link></li>
              </ul>
              <ul className="nav navbar-nav pull-right">
                <li><a href="#">Videos</a></li>
                <li><a href="#">Books</a></li>
                <li><a href="#">Stats</a></li>
              </ul>
            </div>
          </div>
        </nav>
      </header>
    );
  }
}

