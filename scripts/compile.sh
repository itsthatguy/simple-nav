node_modules/.bin/coffee --output . --bare --compile index.coffee
node_modules/.bin/browserify test/app/main.coffee --transform=coffeeify > test/app/main.js
sass --compass test/app/index.scss > test/app/index.css
