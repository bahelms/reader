module.exports = {
  context: __dirname + "/js",
  entry: "./app.js",
  output: {
    filename: "bundle.js",
    path: __dirname
  },
  module: {
    loaders: [
      {
        test: /\.js$/,
        exclude: /node_modules/,
        loaders: ["babel-loader"]
      }
    ]
  }
}
