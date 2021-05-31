export default {
  presets: [
    [
      '@babel/preset-env',
      {
        useBuiltIns: false,
        modules: false // rollup conf will handle this
      }
    ]
  ],
  plugins: [
    ['@babel/plugin-transform-runtime', {
      regenerator: true
    }]
  ],
  comments: false
}
