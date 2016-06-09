NameApp        = require 'steps/name-app'
ChooseProvider = require 'steps/choose-provider'
Summary        = require 'steps/summary'
stepManager    = require 'jade/step-manager'

module.exports = class StepManager

  constructor: ($el, @providers, @submitCb) ->
    @$node = $ stepManager( {} )
    $el.append @$node

    $(".ui-btn.back", @$node).on 'click', ()=> @previousStep()

    @$wrapper     = $ '.step-wrapper', @$node
    @$steps       = $ ".steps", @$node
    @$currentStep = $ "#current-step", @$node
    @$stepTitle   = $ ".step-title", @$node

    $holder = $ '.steps', @$node
    castShadows @$node

    @nameApp        = new NameApp $holder, @nextStep
    @chooseProvider = new ChooseProvider $holder, @nextStep, @providers
    @summary        = new Summary $holder, @submitData, @getData
    @$allSteps    = $ ".launch-step", @$node

    ar = [ @nameApp, @chooseProvider, @summary ]
    @steps = new Sequin( ar )

    @slideToCurrentStep()

  slideToCurrentStep : ()->
    if @currentStep?
      @currentStep.deactivate()
    @currentStep = @steps.currentItem()
    @currentStep.activate()
    @$currentStep.text @steps.currentItemIndex+1
    @$stepTitle.text @currentStep.getTitle()

    @$allSteps.removeClass 'active'
    @currentStep.$node.addClass 'active'
    left = - @steps.currentItem().$node.position().left

    me = @
    setTimeout ()->
      me.$steps.css left: left
    , 100

    # If it's the last item, change the next button to submit
    @$node.removeClass 'submit'
    @$node.removeClass 'first'

    if @steps.isAtLastItem()
      @$node.addClass 'submit'
    else if @steps.currentItemIndex == 0
      @$node.addClass 'first'

  nextStep : () =>
    if @steps.isAtLastItem()
      @submit()
    else
      @steps.next()
      @slideToCurrentStep()

  previousStep : () =>
    @steps.prev()
    @slideToCurrentStep()

  getData : () =>
    data = @chooseProvider.getProviderAndRegion()
    for provider in @providers
      if provider.id == data.provider
        data.meta         = provider.meta
        data.providerName = provider.name
      for region in provider.regions
        if region.id == data.region
          data.regionName = region.name
    data

  submitData : () =>
    data      = @chooseProvider.getProviderAndRegion()
    data.name = @nameApp.getAppName()
    @submitCb data
