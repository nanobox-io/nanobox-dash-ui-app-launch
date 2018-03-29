appImages = require 'jade/app-launch/app-images'
Step      = require 'step'

module.exports = class AppImages extends Step

  constructor: ($el, @nextStepCb, @validateNameCb) ->
    @$node = $ appImages( {} )
    $el.append @$node
    castShadows @$node
    $(".arrow-button", @$node).on "click", ()=> @nextStepCb()
    $(".choice", @$node).on "click", (e)=> @switchMode(e.currentTarget.dataset.id)
    $("#boxfile", @$node).trigger 'click'
    super()

  switchMode : (@mode) ->
    $(".choice", @$node).removeClass 'active'
    $("##{@mode}", @$node).addClass "active"

  getImageMode : () -> @mode

  getTitle : () -> "Choose how you want to build your app's images"
