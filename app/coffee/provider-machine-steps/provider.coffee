Step           = require 'step'
provider = require 'jade/provider-machine/provider'

module.exports = class Provider extends Step

  constructor: ($el, @nextStepCb, @officialProviders, @endpointTester) ->
    @$node = $ provider( {officialProviders:@officialProviders} )
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
      $(".official", @$node).removeClass 'hidden'
      $(".custom", @$node).addClass 'hidden'
      @$next.removeClass 'disabled'
    else
      $(".official", @$node).addClass 'hidden'
      $(".custom", @$node).removeClass 'hidden'
      @$next.addClass 'disabled'


  changeOfficialProvider : (id) =>
    for provider in @officialProviders
      if id == provider.id
        @chosenProvider = provider

  getTitle : () -> "Choose a hosting provider"

  onEndpointTest : (results) =>
    @$testEndpointBtn.removeClass 'ing'
    if !results.error
      @clearError()
      @chosenProvider = results.provider
      @$next.removeClass 'disabled'
      $("#test-endpoint").addClass 'verified disabled'
    else
      @showErrors results.error


  # ------------------------------------ Helpers

  resetCustomUi : () ->
    @$next.addClass 'disabled'
    $("#test-endpoint").removeClass 'verified disabled'

  getProviders : () ->
    [
      {name:"Digital Ocean", icon:"digital-ocean", id:"do"}
      {name:"Google Compute", icon:"google-compute", id:"google", coming:true}
      {name:"Amazon", icon:"aws", id:"aws", coming:true}
      {name:"Joyent", icon:"joyent", id:"joyent", coming:true}
      {name:"Joyent", icon:"joyent", id:"joyent", coming:true}
      {name:"Joyent", icon:"joyent", id:"joyent", coming:true}
      # {name:"Linode", icon:"linode", id:"linode", coming:true}
    ]

  # TODO: Decide how much validation we want to do..
  validateField : (str)-> str.length > 0

  addEventListeners : () ->
    # Next
    @$next = $('#next', @$node)
    @$next.on 'click', @nextStepCb

    # Provider kind (custom / official)
    $kind = $('.kind',  @$node)
    $kind.on 'click', (e)->
      return if e.target.tagName == 'INPUT'
      $('input', $(e.currentTarget)).trigger 'click'
    $('input', $kind).on 'click', (e)=> @changeProviderKind e.currentTarget.value
    $($kind[0]).trigger 'click'

    # Official providers selector
    $provider = $('.provider', @$node)
    $provider.on 'click', (e)->
      return if e.target.tagName == 'INPUT'
      $provider.removeClass 'active'
      $(e.currentTarget).addClass 'active'
      $('input', $(e.currentTarget)).trigger 'click'
    $('input', $provider).on 'click', (e)=> @changeOfficialProvider e.currentTarget.value
    $($provider[0]).trigger 'click'

    # Custom endpoint
    $endpointField = $("#endpoint-url")
    $endpointField.on 'input', ()=>
      @resetCustomUi()
    @$testEndpointBtn = $("#test-endpoint")
    @$testEndpointBtn.on 'click', ()=>
      @$testEndpointBtn.addClass 'ing'
      @endpointTester $endpointField.val(), @onEndpointTest
