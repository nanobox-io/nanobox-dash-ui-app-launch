nameApp = require 'jade/name-app'
Step    = require 'steps/step'

module.exports = class NameApp extends Step

  constructor: ($el, @nextStepCb) ->
    @$node = $ nameApp( {} )
    $el.append @$node
    castShadows @$node

    $(".arrow-btn", @$node).on "click", ()=> @nextStepCb()

    super()

  getTitle : () -> "Name your app"
