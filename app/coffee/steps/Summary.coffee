Step        = require 'steps/step'
summary     = require 'jade/summary'
summaryMeat = require 'jade/summary-meat'

module.exports = class Summary extends Step

  constructor: ($el, @submitCb, @getData) ->
    @$node      = $ summary( {} )
    super()
    $el.append @$node

  build : () ->
    if @meat?
      $("#submit", @meat).off
      @$node.empty()

    @meat = $ summaryMeat( @data )
    @$whatsNext = $ ".whats-next", @meat

    castShadows @meat
    $("#submit", @meat).on 'click', ()=>
      @submitCb()

    $("#server-specs-toggle", @meat).on 'click', ()=>
      $(".blurb", @$meat).toggleClass "expanded"

    @$node.append @meat

  getTitle : () -> "Review and Submit"

  activate : () ->
    @data = @getData()
    @build()

    @fadeInTimout = setTimeout ()=>
      @$whatsNext.removeClass 'cloaked'
    ,
      700

  deactivate : ()->
    clearTimeout @fadeInTimout
    @$whatsNext.addClass 'cloaked'
