nameApp = require 'jade/name-app'

module.exports = class NameApp

  constructor: ($el) ->
    $node = $ nameApp( {} )
    $el.append $node

    console.log 'namer'
