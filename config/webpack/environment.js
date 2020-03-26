const { environment } = require('@rails/webpacker')
const erb = require('./loaders/erb')
const webpack = require("webpack");

environment.plugins.append("Provide", new webpack.ProvidePlugin({
    $: 'jquery',
    jQuery: 'jquery',
    Popper: ['popper.js', 'default']
}));

const aliasConfig = {
    'jquery': 'jquery-ui-dist/external/jquery/jquery.js',
    'jquery-ui': 'jquery-ui-dist/jquery-ui.js'
};

environment.config.set('resolve.alias', aliasConfig);
environment.loaders.prepend('erb', erb)
module.exports = environment
