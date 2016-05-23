Step    = require 'steps/step'
summary = require 'jade/summary'

module.exports = class Summary extends Step

  constructor: ($el, @nextStepCb) ->
    @$node = $ summary( {} )
    $el.append @$node
    castShadows @$node
    super()

  getTitle : () -> "Review and Submit"
