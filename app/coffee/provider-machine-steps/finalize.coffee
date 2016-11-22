Step = require 'step'
finalize = require 'jade/provider-machine/finalize'
providerSelect = require 'jade/select'
module.exports = class Finalize extends Step

  constructor: (@$el, @getProvider, @submit) ->
    @$node         = $ finalize( {} )
    @$regionHolder = $ ".regions", @$node
    @$el.append @$node
    $submitBtn = $("#finalize-create", @$node)
    $submitBtn.on 'click', (e)=>
      $submitBtn.addClass 'ing'
      @submit()

  # ------------------------------------ API

  activate : () ->
    @$regionHolder.empty()
    provider = @getProvider()
    $select = $ providerSelect( {items:provider.regions, classes:"white"} )
    @$regionHolder.append $select
    lexify @$regionHolder

  getName : () => $("#account-name", @$el).val()

  getDefaultRegion : () => $(".regions select", @$el).val()

  getTitle : () -> 'Select default region / finalize'
