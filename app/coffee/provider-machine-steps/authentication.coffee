Step = require 'step'
authentication = require 'jade/provider-machine/authentication'

module.exports = class Authentication extends Step

  constructor: (@$el, @nextStepCb, @getProvider, @verifyAccount) ->
    @$node = $ "<div class='launch-step authentication' />"
    @$el.append @$node

  activate : () ->
    @provider = @getProvider()
    if @$content?
      $('#verify-proceed', @$content).off 'click'
      @$content.remove()
    @$content = $ authentication( @provider )
    @$node.append @$content
    $('#verify-proceed', @$node).on 'click', ()=>
      $rows = $("tr", @$node)
      @authenticationFields = {}
      for row in $rows
        $row   = $(row)
        key = $( ".field", $row).attr "data-key"
        @authenticationFields[key] = $( "input", $row).val()
      @verifyAccount @provider, @authenticationFields, (results)=>
        # TODO: Add error handling..
        # console.log results.error
        # console.log results.verified
        @nextStepCb()

  getAuthentication : ()-> @authenticationFields
  getTitle : () -> "Enter your #{@provider.name} credentials"
