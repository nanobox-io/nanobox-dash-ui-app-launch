chooseProvider = require 'jade/choose-provider'
DropDown       = require 'drop-down'
Step           = require 'steps/step'

module.exports = class ChooseProvider extends Step

  constructor: ($el, @nextStepCb, @providers) ->
    @$node = $ chooseProvider( {providers:@providers} )
    $el.append @$node
    castShadows @$node

    $(".arrow-btn", @$node).on "click", ()=> @nextStepCb()

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
        ar.push {name:provider.name, providerId: provider.id, id: provider.accounts[0].id }

    else
      for provider in @providers
        ar.push {name:provider.name, isLabel:true }
        for account in provider.accounts
          ar.push {name:account.name, id: account.id }

    @provider = new DropDown $("#provider", @$node), ar, @onProviderChange

    if !multipleAccountsPerProvider
      @onProviderChange ar[0].id
    else
      @onProviderChange ar[1].id

  onProviderChange : (id) =>
    for provider in @providers
      for account in provider.accounts
        if account.id == id
          @regionDropDown?.destroy()
          @setDefaultRegion provider.regions, account.default_region
          @regionDropDown = new DropDown $("#region", @$node), provider.regions, @onRegionChange
          $iconHolder = $(".provider-icon", @$node)
          $iconHolder.empty()
          $iconHolder.append $("<img data-src='#{provider.meta.icon}' class='shadow-icon' />")
          castShadows $iconHolder
          return

  getTitle : () -> "Choose a Provider and Region"

  onRegionChange : () ->
    # @region?.remove()
    # @region = new DropDown $("#region", $node), ar, @onProviderChange

  setDefaultRegion : (regions, regionId) ->
    for region in regions
      if region.id == regionId
        region.selected = true
        return




  getProviderAndRegion : () =>
    {provider_account_id: @provider.val(), region:@regionDropDown.val()}
