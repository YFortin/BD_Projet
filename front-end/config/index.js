module.exports = {
    devServer: {
      proxy: {
        '*': {
          target: 'http://app:5000',
          ws: true,
          changeOrigin: true
        },
      }
    }
  }