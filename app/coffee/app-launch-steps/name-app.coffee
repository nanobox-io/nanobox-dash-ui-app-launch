nameApp = require 'jade/app-launch/name-app'
Step    = require 'step'

module.exports = class NameApp extends Step

  constructor: ($el, @nextStepCb) ->
    @$node = $ nameApp( {} )
    $el.append @$node
    castShadows @$node

    $(".arrow-btn", @$node).on "click", ()=> @nextStepCb()

    super()

  getAppName : ()-> $('input', @$node).val()

  getTitle : () -> "Name your app"
