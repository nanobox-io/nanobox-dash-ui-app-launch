StepManager    = require 'step-manager'
Provider       = require 'provider-machine-steps/provider'
Authentication = require 'provider-machine-steps/authentication'
Finalize       = require 'provider-machine-steps/finalize'

module.exports = class ProviderMachine

  constructor: ($el, @config) ->
    @stepManager = new StepManager $el, @config.onCancel
    @createSteps()

  createSteps : () ->
    $holder         = @stepManager.build()
    @provider       = new Provider $holder, @stepManager.nextStep
    @authentication = new Authentication $holder, @stepManager.nextStep
    @finalize       = new Finalize $holder, @submitData
    steps = [@provider, @authentication, @finalize]
    @stepManager.addSteps steps

  submitData : () ->
