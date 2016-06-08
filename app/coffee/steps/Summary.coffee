Step    = require 'steps/step'
summary = require 'jade/summary'

module.exports = class Summary extends Step

  constructor: ($el, submitCb) ->
    @$node      = $ summary( {} )
    @$whatsNext = $ ".whats-next", @$node

    $el.append @$node
    castShadows @$node
    $("#submit", @$node).on 'click', ()-> submitCb()
    super()

  getTitle : () -> "Review and Submit"

  activate : () ->
    @fadeInTimout = setTimeout ()=>
      @$whatsNext.removeClass 'cloaked'
    ,
      700

  deactivate : ()->
    clearTimeout @fadeInTimout
    @$whatsNext.addClass 'cloaked'
