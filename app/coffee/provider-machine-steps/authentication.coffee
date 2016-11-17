Step = require 'step'

module.exports = class Authentication extends Step

  constructor: ($el, @nextStepCb) ->
