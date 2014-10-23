require('./test_helper')
Q       = require('q')
Server  = require('./test_server')
phantom = require('phantom')

describe 'simple-nav', ->

  page = ph = hasElement = null

  before (done) ->
    phantom.create (_ph) ->
      ph = _ph
      done()

  before (done) ->
    ph.createPage (_page) ->
      _page.open 'http://localhost:7458', (status) ->
        page = _page
        page.hasElement = (selector) ->
          self = @
          options =
            selector: selector

          return Q.Promise (resolve, reject, notify) ->
            self.evaluate((opts) ->
              return $(opts.selector).filter(':visible').size() && true || false
            , (_result) ->
              resolve(_result)
            , options)

        page.onConsoleMessage console.log
        done()

  context 'when resized to desktop', ->
    before -> page.set('viewportSize', {width: 1000, height: 1000})

    it 'has visible nav links', ->
      page.hasElement('.nav-links').then (value) -> value.should.be.true

  context 'when resized to mobile', ->
    before -> page.set('viewportSize', {width: 100, height: 1000})

    it 'doesn\'t have visible nav links', ->
      page.hasElement('.nav-links').then (value) -> value.should.not.be.true
