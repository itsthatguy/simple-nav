_ = require('underscore')

class Navigation
  defaults:
    scrolledClass: 'scrolled'
    expandedClass: 'open'
    scrollTolerance: 120
    gotoSpeed: 10

  options: {}

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
    @handleScroll()
    @gotoAnchor(window.location.hash) if window.location.hash

  setTolerance: (n) -> @options.scrollTolerance = n

  closeMenu: ->
    $('body').removeClass(@options.expandedClass)

  toggleMenu: (e) =>
    e.preventDefault()

    if $("body.#{@options.expandedClass}").length > 0
      @closeMenu()
    else
      $('body').addClass(@options.expandedClass)

  handleScroll: =>
    if document.body.scrollTop <= @options.scrollTolerance
      $('body').removeClass(@options.scrolledClass)
    else
      $('body').addClass(@options.scrolledClass)

  gotoAnchor: (anchor) ->
    if $(anchor).length > 0
      speed    = @options.gotoSpeed
      position = $(anchor).offset().top
      distance = position - $(document).scrollTop()
      time     = Math.abs(distance) / speed

      $('html, body').animate
        scrollTop: position
      , Math.floor time

module.exports = Navigation
