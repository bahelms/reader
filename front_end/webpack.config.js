var HtmlWebpackPlugin = require("html-webpack-plugin");
var webpack = require("webpack");
var appPath = __dirname + "/app";

module.exports = {
  entry: appPath,
  output: {
    path: __dirname + "/build",
    filename: "bundle.js"
  },
  devServer: {
    historyApiFallback: true,
    hot: true,
    inline: true,
    progress: true
  },
  plugins: [
    new HtmlWebpackPlugin({title: "Welcome to The Reader"}),
    new webpack.HotModuleReplacementPlugin()
  ],
  module: {
    preloaders: [
      { test: /\.jsx?$/, include: appPath, loaders: ["eslint"] },
    ],
    loaders: [
      { test: /\.jsx?$/, include: appPath, loaders: ["babel"] },
      { test: /\.css$/, include: appPath, loaders: ["style", "css"] },
    ]
  }
}
