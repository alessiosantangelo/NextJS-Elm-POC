module.exports = {
    webpack: (
      config,
      { buildId, dev, isServer, defaultLoaders, nextRuntime, webpack }
    ) => {
      
    
    config.module.rules.push({
        test: /\.elm$/,
        exclude: [/elm-stuff/, /node_modules/],
        loader: require.resolve('elm-webpack-loader')
    })
        
      return config
    },
}