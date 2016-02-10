var HtmlWebpackPlugin = require("html-webpack-plugin");
var webpack = require("webpack");
var appPath = __dirname + "/app";

module.exports = {
  entry: ["bootstrap-loader", appPath],
  output: {
    path: __dirname + "/build",
    filename: "bundle.js",
    publicPath: "/"
  },
  devServer: {
    historyApiFallback: true,
    hot: true,
    inline: true,
    progress: true
  },
  plugins: [
    new HtmlWebpackPlugin({template: "app/index.html", inject: "body"}),
    new webpack.HotModuleReplacementPlugin(),
    new webpack.ProvidePlugin({$: "jquery", jQuery: "jquery"})
  ],
  module: {
    preloaders: [
      { test: /\.jsx?$/, include: appPath, loaders: ["eslint"] },
    ],
    loaders: [
      { test: /\.jsx?$/, include: appPath, loaders: ["babel"] },
      { test: /\.css$/, include: appPath, loaders: ["style", "css"] },
      { test: /\.scss$/, include: appPath, loader: "style!css!sass" },
      { test: /\.eot(\?v=\d+\.\d+\.\d+)?$/, loader: "file" },
      { test: /\.(woff|woff2)$/, loader:"url?prefix=font/&limit=5000" },
      { test: /\.ttf(\?v=\d+\.\d+\.\d+)?$/, loader: "url?limit=10000&mimetype=application/octet-stream" },
      { test: /\.svg(\?v=\d+\.\d+\.\d+)?$/, loader: "url?limit=10000&mimetype=image/svg+xml" }
    ]
  }
}
