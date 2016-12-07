Step = require 'step'
finalize = require 'jade/provider-machine/finalize'
providerSelect = require 'jade/select'
module.exports = class Finalize extends Step

  constructor: (@$el, @getProvider, @submit) ->
    @$node         = $ finalize( {} )
    @$regionHolder = $ ".regions", @$node
    @$el.append @$node
    @$submitBtn = $("#finalize-create", @$node)
    @$submitBtn.on 'click', (e)=>
      @clearError()
      @$submitBtn.addClass 'ing'
      @submit()

  # ------------------------------------ API

  activate : () ->
    @$regionHolder.empty()
    provider = @getProvider()
    $select = $ providerSelect( {items:provider.regions, classes:"white"} )
    @$regionHolder.append $select
    lexify @$regionHolder

  submitError : (error) =>
    @showErrors error
    @$submitBtn.removeClass 'ing'

  submitSuccessful : (results)->
    @$submitBtn.removeClass 'ing'
    @$submitBtn.css 'pointer-events' : 'none'
    $('.txt', @$submitBtn).text "Success!"

  getName : () => $("#account-name", @$el).val()

  getDefaultRegion : () => $(".regions select", @$el).val()

  getTitle : () -> 'Select default region / finalize'
