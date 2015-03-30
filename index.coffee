_ = require('underscore')

class Navigation
  defaults:
    scrolledClass: 'scrolled'
    expandedClass: 'open'
    scrollTolerance: 120
    gotoSpeed: 10

    gotoAnchorTimer: 500
    handleScrollTimer: 300
    toggleMenuTimer: 300

  options: {}

  constructor: (options) ->
    _.defaults(@options, @defaults)
    _.extend(@options, options)

    @_gotoAnchor   = _.throttle @gotoAnchor, @options.gotoAnchorTimer, { trailing: false }
    @_handleScroll = _.throttle @handleScroll, @options.handleScrollTimer, true
    @_toggleMenu   = _.throttle @toggleMenu, @options.toggleMenuTimer, true

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
    if window.pageYOffset <= @options.scrollTolerance
      $('body').removeClass(@options.scrolledClass)
    else
      $('body').addClass(@options.scrolledClass)

  gotoAnchor: (anchor) ->
    if $(anchor).length > 0
      speed    = @options.gotoSpeed
      position = $(anchor).offset().top
      distance = position - window.pageYOffset
      time     = Math.abs(distance) / speed

      $('html, body').animate
        scrollTop: position
      , Math.floor time

module.exports = Navigation
