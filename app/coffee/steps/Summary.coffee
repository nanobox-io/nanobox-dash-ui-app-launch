Step    = require 'steps/step'

module.exports = class Summary extends Step

  constructor: ($el, @nextStepCb) ->
    super
