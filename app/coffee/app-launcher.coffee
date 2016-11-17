StepManager    = require 'step-manager'
noProvider     = require 'jade/no-provider'
NameApp        = require 'app-launch-steps/name-app'
ChooseProvider = require 'app-launch-steps/choose-provider'
Summary        = require 'app-launch-steps/summary'

module.exports = class AppLauncher

  constructor: ($el, @config) ->
    if @userHasAtLeastOneAccount(@config)
      @stepManager = new StepManager $el, @config.onCancel
      @createSteps()
    else
      $node = $ noProvider( {} )
      $el.append $node

  createSteps : () ->
    $holder         = @stepManager.build()
    @nameApp        = new NameApp $holder, @stepManager.nextStep
    @chooseProvider = new ChooseProvider $holder, @stepManager.nextStep, @config.providers
    @summary        = new Summary $holder, @submitData, @getData
    steps = [ @nameApp, @chooseProvider, @summary ]
    @stepManager.addSteps steps

  getData : () =>
    data = @chooseProvider.getProviderAndRegion()
    for provider in @config.providers
      for account in provider.accounts
        if account.id == data.provider_account_id
          data.meta         = provider.meta
          data.providerName = provider.name
          data.accountName  = account.name
          data.accountId    = account.id
        for region in provider.regions
          if region.id == data.region
            data.regionName = region.name
    data

  submitData : () =>
    data      = @chooseProvider.getProviderAndRegion()
    data.name = @nameApp.getAppName()
    @config.appLaunchCb data

  userHasAtLeastOneAccount : (config) ->
    hasAccount = false
    for i in [config.providers.length-1..0]
      # If there is no account for a certain provider, remove it from the array
      if config.providers[i].accounts.length == 0
        config.providers.splice i, 1
      # else, note that there is at least one account
      else
        hasAccount = true
    return hasAccount

  destroy : () ->
    @stepManager.destroy()
    @nameApp.destroy()
    @chooseProvider.destroy()
    @summary.destroy()
