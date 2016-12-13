Step           = require 'step'
provider = require 'jade/provider-machine/provider'

module.exports = class Provider extends Step

  constructor: ($el, @nextStepCb, @officialProviders, @customProviders, @endpointTester) ->
    @$node = $ provider( {officialProviders:@officialProviders, customProviders:@customProviders} )
    $el.append @$node
    castShadows @$node
    lexify @$node
    @addEventListeners()

  # ------------------------------------ API

  getProvider : () =>
    @chosenProvider

  # ------------------------------------ Event Listeners

  changeProviderKind : (kind) ->
    @clearError()
    if kind == "official"
      @activateOfficalProviders()
    else
      @activateCustomProviders()

  activateOfficalProviders : () ->
    $(".official", @$node).removeClass 'hidden'
    $(".custom", @$node).addClass 'hidden'
    $(@$officialProvider[0]).trigger 'click'
    @$next.removeClass 'disabled'

  activateCustomProviders : () ->
    $(".official", @$node).addClass 'hidden'
    $(".custom", @$node).removeClass 'hidden'
    # If there are existing custom providers, click the first one
    if @customProviders.length > 0
      $(@$customProvider[0]).trigger 'click'
      # @resetCustomUi()
    # Else they are adding a custom endpoint and
    # disable next button until it's been verified
    else
      if !@endpointValidated
        @$next.addClass 'disabled'

  changeOfficialProvider : (id) =>
    for provider in @officialProviders
      if id == provider.id
        @chosenProvider = provider

  changeCustomProvider : (id) =>
    # If they are adding a new custom provider
    if id == 'new-custom'
      if !@endpointValidated
        @$next.addClass 'disabled'
      $(".endpoint", @$node).removeClass 'hidden'
    else
      @$next.removeClass 'disabled'
      $(".endpoint", @$node).addClass 'hidden'

    for provider in @customProviders
      if id == provider.id
        @chosenProvider = provider

  getTitle : () -> "Choose a hosting provider"

  onEndpointTest : (results) =>
    @$testEndpointBtn.removeClass 'ing'
    if !results.error
      @endpointValidated = true
      @clearError()
      @chosenProvider = results.provider
      @$next.removeClass 'disabled'
      $("#test-endpoint").addClass 'verified disabled'
    else
      @showErrors results.error


  # ------------------------------------ Helpers

  resetCustomUi : () ->
    @endpointValidated = false
    @$next.addClass 'disabled'
    $("#test-endpoint").removeClass 'verified disabled'

  getEndpoint : () => @endpoint

  validateField : (str)-> str.length > 0

  addEventListeners : () ->
    # Next
    @$next = $('#next', @$node)
    @$next.on 'click', @nextStepCb

    # Official providers selector
    @$officialProvider = $('.official-provider', @$node)
    @$officialProvider.on 'click', (e)=>
      return if e.target.tagName == 'INPUT'
      @$officialProvider.removeClass 'active'
      $(e.currentTarget).addClass 'active'
      $('input', $(e.currentTarget)).trigger 'click'
    $('input', @$officialProvider).on 'click', (e)=> @changeOfficialProvider e.currentTarget.value
    $(@$officialProvider[0]).trigger 'click'

    # Existing custom providers selector
    @$customProvider = $('.custom-provider', @$node)
    @$customProvider.on 'click', (e)=>
      return if e.target.tagName == 'INPUT'
      @$customProvider.removeClass 'active'
      $(e.currentTarget).addClass 'active'
      $('input', $(e.currentTarget)).trigger 'click'
    $('input', @$customProvider).on 'click', (e)=> @changeCustomProvider e.currentTarget.value

    # Provider kind (custom / official)
    $kind = $('.kind',  @$node)
    $kind.on 'click', (e)->
      return if e.target.tagName == 'INPUT'
      $('input', $(e.currentTarget)).trigger 'click'
    $('input', $kind).on 'click', (e)=> @changeProviderKind e.currentTarget.value
    $($kind[0]).trigger 'click'

    # Custom endpoint
    $endpointField = $("#endpoint-url")
    $endpointField.on 'input', ()=>
      @resetCustomUi()
    @$testEndpointBtn = $("#test-endpoint")
    @$testEndpointBtn.on 'click', ()=>
      @$testEndpointBtn.addClass 'ing'
      @endpoint = $endpointField.val()
      @endpointTester @endpoint, @onEndpointTest
