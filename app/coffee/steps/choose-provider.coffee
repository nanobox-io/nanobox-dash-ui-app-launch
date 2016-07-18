chooseProvider = require 'jade/choose-provider'
DropDown       = require 'drop-down'
Step           = require 'steps/step'

module.exports = class ChooseProvider extends Step

  constructor: ($el, @nextStepCb, @providers) ->
    @$node = $ chooseProvider( {providers:@providers} )
    $el.append @$node
    castShadows @$node

    $(".arrow-btn", @$node).on "click", ()=> @nextStepCb()

    ar = []
    for provider in @providers
      ar.push {name:provider.name, id: provider.id}

    @provider = new DropDown $("#provider", @$node), ar, @onProviderChange
    @onProviderChange ar[0].id
    super()

  onProviderChange : (id) =>
    for provider in @providers
      if provider.id == id
        @regionDropDown?.destroy()
        @regionDropDown = new DropDown $("#region", @$node), provider.regions, @onRegionChange
        $iconHolder = $(".provider-icon", @$node)
        $iconHolder.empty()
        $iconHolder.append $("<img data-src='#{provider.meta.icon}' class='shadow-icon' />")
        castShadows $iconHolder


  getTitle : () -> "Choose a Provider and Region"

  onRegionChange : () ->
    # @region?.remove()
    # @region = new DropDown $("#region", $node), ar, @onProviderChange

  getProviderAndRegion : () =>
    {provider: @provider.val(), region:@regionDropDown.val()}
