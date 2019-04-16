module.exports = {
    devServer: {
        proxy: {
            '^/*': {
                target: 'http://app:5000',
                changeOrigin: true
            },
        }
    }
}