module.exports = {
    devServer: {
        proxy: {
            '/signup': {
                target: 'http://app:5000',
                changeOrigin: true
            },
        }
    }
}