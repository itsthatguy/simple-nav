express = require('express')

app = express()
app.use(express.static(__dirname + '/app'))

class Server
  defaults:
    host: 'http://localhost'
    port: 7458

  options: {}

  constructor: (options = {}) ->
    @options.port = options.port || @defaults.port
    @options.host = options.host || @defaults.host
    app.listen(@options.port)

module.exports = new Server()
