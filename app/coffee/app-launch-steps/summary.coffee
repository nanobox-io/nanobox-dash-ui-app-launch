Step        = require 'step'
summary     = require 'jade/app-launch/summary'
summaryMeat = require 'jade/app-launch/summary-meat'

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
    @$submit = $("#submit", @meat)
    @$submit.on 'click', ()=>
      @$submit.addClass 'ing'
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
