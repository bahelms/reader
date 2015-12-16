import React from "react";

export default class Article extends React.Component {
  componentDidMount() {
  }

  render() {
    // return
    //   <div className="row">
    //     <div className="row">
    //       <div className="col-md-1 col-md-offset-4 text-right">
    //         <strong>Title:</strong>
    //       </div>
    //       <div className="col-md-7"><%= @article.title %></div>
    //     </div>
    //     <div className="row">
    //       <div className="col-md-1 col-md-offset-4 text-right">
    //         <strong>URL:</strong>
    //       </div>
    //       <div className="col-md-7">
    //         <%= link @article.url, to: @article.url, target: "_blank"%>
    //       </div>
    //     </div>
    //     <div className="row">
    //       <div className="col-md-1 col-md-offset-4 text-right">
    //         <strong>Category:</strong>
    //       </div>
    //       <div className="col-md-7"><%= @article.category %></div>
    //     </div>
    //     <div className="row">
    //       <div className="col-md-1 col-md-offset-4 text-right">
    //         <strong>Read:</strong>
    //       </div>
    //       <div className="col-md-7"><%= @article.read %></div>
    //     </div>
    //     <div className="row">
    //       <div className="col-md-1 col-md-offset-4 text-right">
    //         <strong>Favorite:</strong>
    //       </div>
    //       <div className="col-md-7"><%= @article.favorite %></div>
    //     </div>
    //   </div>

    //   <div class="row" id="edit_article_buttons">
    //     <div class="col-md-4 col-md-offset-4">
    //       <%= status_button(:favorite, @conn, @article) %>
    //       <%= status_button(:read, @conn, @article) %>
    //       <%= link "Edit", to: article_path(@conn, :edit, @article),
    //         class: "btn btn-warning" %>
    //     </div>
    //     <div class="col-md-1 pull-right">
    //       <%= button "Delete", to: article_path(@conn, :delete, @article),
    //         method: "delete", class: "btn btn-danger", "data-behavior": "confirm" %>
    //     </div>
    //   </div>
  }
}
