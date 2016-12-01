nameApp = require 'jade/app-launch/name-app'
Step    = require 'step'

module.exports = class NameApp extends Step

  constructor: ($el, @nextStepCb, @validateNameCb) ->
    @$node = $ nameApp( {} )
    $el.append @$node
    castShadows @$node

    $arrowBtn = $("#test-name", @$node)
    $btnTxt   = $(".txt", $arrowBtn)

    $arrowBtn.on "click", ()=>
      @clearError()
      appName = @getAppName()
      # If appname is blank, go on to the next step
      if appName.length == 0
        @nextStepCb()
      # else, validate allowed characters and uniqueness
      else
        $arrowBtn.addClass 'ing'
        # $btnTxt.text 'Validating'
        @validateNameCb @getAppName(), (data)=>
          # $btnTxt.text 'Next'
          $arrowBtn.removeClass 'ing'
          if !data.error?
            @nextStepCb()
          else
            @showErrors data.error

    super()

  getAppName : ()-> $('input', @$node).val()

  getTitle : () -> "Name your app"
