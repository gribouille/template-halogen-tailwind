const path                     = require('path')
const { execSync }             = require('child_process')
const webpack                  = require('webpack')
const { merge }                = require('webpack-merge')
const HtmlWebpackPlugin        = require('html-webpack-plugin')
const CopyPlugin               = require('copy-webpack-plugin')
const { CleanWebpackPlugin }   = require('clean-webpack-plugin')
const { BundleAnalyzerPlugin } = require('webpack-bundle-analyzer')
const MiniCssExtractPlugin     = require("mini-css-extract-plugin")
const CreateFileWebpack        = require('create-file-webpack')

const TITLE         = 'Template Halogen Tailwind'
const DESCRIPTION   = 'Project\'s template for PureScript + Halogen + Tailwind.'
const AUTHOR        = 'Gribouille <gribouille.git@gmail.com>'
const NAME          = 'template-halogen-tailwind'
const CONTACT       = 'gribouille.git@gmail.com'
const DOCUMENTATION = 'https://github.com/gribouille/template-halogen-tailwind/wiki'

const MODE          = process.env.NODE_ENV || 'development'
const DEV_PORT      = process.env.PORT || 3000
const DEV_HOST      = process.env.HOST || '0.0.0.0'
const SER_PORT      = process.env.SERVER_PORT || 4000
const SER_HOST      = process.env.SERVER_HOST || '0.0.0.0'
const DEBUG         = process.env.DEBUG || 'no'
const TARGET        = path.resolve(__dirname, 'dist')
const CORS          = process.env.CORS || 'no'

const pth = x => path.resolve(__dirname, x)
const git_commit = () => execSync('git log -n 1 --pretty="format:%h"').toString().trim()
const git_date = () => execSync('git log -n 1 --pretty="format:%cd"').toString().trim()
const git_tag = () => execSync('git describe --abbrev=0 --tags').toString().trim()


const common = {
  mode  : MODE,
  entry    : pth('index.js'),
  output: {
    path      : TARGET,
    filename  : MODE === 'production' ? '[name]-[contenthash].js': '[name].js',
    publicPath: '',
    clean: true,
  },
  resolve: {
    modules   : [pth('src'), pth('node_modules')],
    extensions: ['.js', '.json']
  },
  module: {
    rules: [
      {
        test: /\.(png|svg|jpg|jpeg|gif)$/i,
        type: "asset/resource",
      },
      {
        test: /\.(woff|woff2|eot|ttf|otf)$/i,
        type: "asset/resource",
      },
      {
        test: /\.css$/i,
        exclude: /node_modules/,
        use : [
          MiniCssExtractPlugin.loader,
          'css-loader',
          'postcss-loader'
        ]
      }
    ]
  },
  plugins: [
    new HtmlWebpackPlugin({
      title     : TITLE,
      favicon   : path.resolve(__dirname, 'assets', 'favicon.png'),
      showErrors: MODE !== 'production',
      meta      : {
        charset    : 'utf-8',
        viewport   : 'width=device-width, initial-scale=1, shrink-to-fit=no',
        description: DESCRIPTION,
        author     : AUTHOR,
      }
    }),
    new MiniCssExtractPlugin({
      filename: "[name].[contenthash].css",
    }),
    new CleanWebpackPlugin({
      root   : __dirname,
      exclude: [],
      verbose: true,
      dry    : false
    }),
    new CopyPlugin({
      patterns: [
        { from:  pth('assets'), to: path.resolve(TARGET, 'assets') },
      ]
    }),
    new webpack.DefinePlugin({
      INFO_NAME         : JSON.stringify(NAME),
      INFO_TITLE        : JSON.stringify(TITLE),
      INFO_DESCRIPTION  : JSON.stringify(DESCRIPTION),
      INFO_CONTACT      : JSON.stringify(CONTACT),
      INFO_DOCUMENTATION: JSON.stringify(DOCUMENTATION),
      VERSION_COMMIT    : JSON.stringify(git_commit()),
      VERSION_TAG       : JSON.stringify(git_tag()),
      VERSION_DATE      : JSON.stringify(git_date()),
    }),
  ],
  optimization: {
    minimize   : true,
    splitChunks: {
      chunks: 'all'
    }
  }
}

const envDev = `
export default {
  protocol  : 'http',
  hostname  : '',
  gateway   : '/api',
  region    : 'local',
  log_level : 'debug',
}
`

const production = {
  devtool: 'source-map',
  module : {
    rules: [
    ]
  },
  plugins: [
  ]
}

const development = {
  devtool  : 'eval-source-map',
  devServer: {
    devMiddleware: {
      publicPath: '/',
    },
    static: {
      directory: TARGET,
    },
    compress: true,
    allowedHosts      : "all",
    historyApiFallback: true,
    host              : DEV_HOST,
    port              : DEV_PORT,
    hot               : true,
    watchFiles        : ['src/**/*.purs', 'styles/**/*.css', 'test/**/*', 'assets/**/*'],
    headers: CORS !== 'yes'? {}: {
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Methods": "GET, POST, PUT, DELETE, PATCH, OPTIONS",
      "Access-Control-Allow-Headers": "X-Requested-With, content-type, Authorization"
    },
    proxy: {
      '/api': {
        target     : `${SER_HOST}:${SER_PORT}`,
        pathRewrite: {
          '^/api/': ''
        },
        secure: false
      },
    }
  },
  module: {
    rules: DEBUG === 'yes' ? [new BundleAnalyzerPlugin()] : []
  },
  optimization: {
    splitChunks: {
      chunks: 'all'
    }
  },
  plugins: [
    new CreateFileWebpack({
      path: TARGET,
      fileName: 'env.js',
      content: envDev
    })
  ]
}

module.exports = merge(common, MODE === 'production' ? production : development)
