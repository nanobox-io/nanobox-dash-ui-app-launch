StepManager    = require 'step-manager'
Provider       = require 'provider-machine-steps/provider'
Authentication = require 'provider-machine-steps/authentication'
Finalize       = require 'provider-machine-steps/finalize'
noProvider     = require 'jade/no-provider'

module.exports = class ProviderMachine

  constructor: (@$el, @config) ->
    if @config.hasAccounts
      @go()
    else
      $node = $ noProvider( {} )
      @$el.append $node
      $("#connect-provider", $node).on 'click', ()=> @go()
      castShadows $node

  go : ()->
    @$el.empty()
    @stepManager = new StepManager @$el, @config.onCancel
    @createSteps()

  createSteps : () ->
    $holder         = @stepManager.build()
    @provider       = new Provider $holder, @stepManager.nextStep, @config.officialProviders, @config.endpointTester
    @authentication = new Authentication $holder, @stepManager.nextStep, @provider.getProvider, @provider.getEndpoint, @config.verifyAccount
    @finalize       = new Finalize $holder, @provider.getProvider, @submitData
    steps = [@provider, @authentication, @finalize]
    @stepManager.addSteps steps

  submitData : () =>
    data =
      provider       : @provider.getProvider()
      authentication : @authentication.getAuthentication()
      name           : @finalize.getName()
      defaultRegion  : @finalize.getDefaultRegion()
      endpoint       : @provider.getEndpoint()
    @config.addProviderCb data, (results)=>
      if results.error
        @finalize.submitError results.error
      else
        @finalize.submitSuccessful results
