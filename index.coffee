_ = require('underscore')

class Navigation
  defaults:
    scrollTolerance: 120
    gotoSpeed: 10

  options: {}

  setTolerance: (n) -> @options.scrollTolerance = n

  closeMenu: ->
    $('body').removeClass('open')

  toggleMenu: (e) =>
    e.preventDefault()

    if $('body.open').length > 0
      @closeMenu()
    else
      $('body').addClass('open')

  handleScroll: (e) =>
    if $(e.target).scrollTop() <= @options.scrollTolerance
      $('body').removeClass('scrolled')
    else
      $('body').addClass('scrolled')

  gotoAnchor: (anchor) ->
    if $(anchor).length > 0
      speed    = @options.gotoSpeed
      position = $(anchor).offset().top
      distance = position - $(document).scrollTop()
      time     = Math.abs(distance) / speed

      $('html, body').animate
        scrollTop: position
      , Math.floor time

  constructor: (options) ->
    _.defaults(@options, @defaults)
    _.extend(@options, options)

    @_gotoAnchor   = _.throttle @gotoAnchor, 500, { trailing: false }
    @_handleScroll = _.throttle @handleScroll, 300, true
    @_toggleMenu   = _.throttle @toggleMenu, 300, true

    $('.menu').on 'click', @_toggleMenu

    $('.navigation [href]').on 'click', (e) =>
      e.preventDefault()
      @closeMenu()
      @_gotoAnchor($(e.currentTarget).attr('href'))

    $.each $('.title'), ->
      offset = $(this).find('a').outerWidth()
      $(this).find('.tooltip').css('left', offset)

    $(document).on 'scroll', @_handleScroll
    $ =>
      @handleScroll(window)
      if window.location.hash
        @gotoAnchor(window.location.hash)

module.exports = Navigation
