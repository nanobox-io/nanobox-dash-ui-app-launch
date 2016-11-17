Step           = require 'step'
provider = require 'jade/provider-machine/provider'

module.exports = class Provider extends Step

  constructor: ($el, @nextStepCb) ->
    @$node = $ provider( {} )
    $el.append @$node
    castShadows @$node

  getTitle : () -> "Choose a hosting provider"
