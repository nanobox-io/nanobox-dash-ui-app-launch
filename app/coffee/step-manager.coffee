NameApp        = require 'steps/name-app'
ChooseProvider = require 'steps/choose-provider'
Summary        = require 'steps/summary'
stepManager    = require 'jade/step-manager'

module.exports = class StepManager

  constructor: ($el) ->
    $node = $ stepManager( {} )
    $el.append $node

    $holder = $ '.steps', $node
    castShadows $node

    nameApp        = new NameApp $holder
    chooseProvider = new ChooseProvider $holder
    summary        = new Summary $holder

    ar = [nameApp, chooseProvider, summary]
    @sequence = new Sequin( ar )
