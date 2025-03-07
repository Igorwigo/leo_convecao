module.exports = {
    content: [
        './public/*.html',
        './app/helpers/**/*.rb',
        './app/javascript/**/*.js',
        './app/views/**/*.{erb,haml,html,slim}'
    ],
    theme: {
        extend: {
            container: {
                center: true,
                padding: '1rem'
            }
        },
    },
    plugins: [],
}