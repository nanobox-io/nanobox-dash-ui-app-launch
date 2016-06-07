Step    = require 'steps/step'
summary = require 'jade/summary'

module.exports = class Summary extends Step

  constructor: ($el, getProviderAndRegion, submitCb) ->
    @$node = $ summary( {} )
    $el.append @$node
    castShadows @$node
    $("#submit", @$node).on 'click', ()-> submitCb( getProviderAndRegion() )
    super()

  getTitle : () -> "Review and Submit"
