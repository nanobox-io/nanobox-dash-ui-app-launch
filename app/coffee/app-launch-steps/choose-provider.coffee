chooseProvider = require 'jade/app-launch/choose-provider'
Step           = require 'step'
select         = require 'jade/select'

module.exports = class ChooseProvider extends Step

  constructor: ($el, @nextStepCb, @providers) ->
    @$node = $ chooseProvider( {providers:@providers} )
    $el.append @$node
    castShadows @$node

    $(".arrow-button", @$node).on "click", ()=> @nextStepCb()

    @populateProviderDropDown()
    super()

  populateProviderDropDown : () ->
    # Check to see if any of their providers have multiple accounts
    for provider in @providers
      if provider.accounts.length > 1
        multipleAccountsPerProvider = true
        break

    ar = []
    if !multipleAccountsPerProvider
      for provider in @providers
        ar.push {name:provider.name, id:provider.accounts[0].id}

    else
      for provider in @providers
        obj = {group:provider.name, items:[]}
        ar.push obj
        for account in provider.accounts
          obj.items.push {name:account.name, id:account.id}

    $node = $(select( {items:ar} ))
    $node.on 'change', (e)=> @onProviderChange e.currentTarget.value
    $node.trigger 'change'
    $("#provider", @$node).append $node
    lexify $("#provider", @$node)

  onProviderChange : (@currentProviderId) =>
    for provider in @providers
      for account in provider.accounts
        if account.id == @currentProviderId
          @regionDropDown?.destroy()
          @setDefaultRegion provider.regions, account.default_region
          $node = $(select( {items:provider.regions} ))
          $node.on 'change', (e)=> @onRegionChange e.currentTarget.value
          $node.trigger 'change'
          $("#region", @$node).empty().append $node
          lexify $("#region", @$node)
          $iconHolder = $(".provider-icon", @$node)
          $iconHolder.empty()
          if provider.meta.icon == "custom"
            provider.meta.icon = "custom-provider-atoms"
          $iconHolder.append $("<img data-src='#{provider.meta.icon}' class='shadow-icon' />")
          castShadows $iconHolder
          return

  getTitle : () -> "Choose a Provider and Region"

  onRegionChange : (@currentRegion) ->

  setDefaultRegion : (regions, regionId) ->
    for region in regions
      if region.id == regionId
        region.selected = true
        return
      if region.items?
        for subRegion in region.items
          if subRegion.id == regionId
            subRegion.selected = true

  getProviderAndRegion : () =>
    {provider_account_id: @currentProviderId, region:@currentRegion}
