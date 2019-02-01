module.exports = {
  "env": {
    "browser": true,
    "es6": true,
    "node": true
  },
  "parserOptions": {
    "parser": "babel-eslint"
  },
  "extends": [
    "airbnb-base",
    "plugin:vue/recommended"
  ],
  "rules": {
    "no-console": "off",
  },
  "globals": {
    "ethereum": true,
    "web3": true,
  },
};    