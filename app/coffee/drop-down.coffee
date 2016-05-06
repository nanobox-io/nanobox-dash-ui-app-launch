dropDown = require 'jade/drop-down'

module.exports = class DropDown

  constructor: (@$el, @options, @onChangeCb) ->
    @$el.addClass 'drop-down-trigger'
    @$el.text @getSelectedOptionName( @options )
    @$el.on "mousedown", (e)=>
      # If there is a dropdown active on the page, deactivate
      DropDown.activeDropDown?.hideOptions()
      DropDown.activeDropDown = @

      @openTime = Date.now()
      e.stopPropagation()
      @showOptions()
    @$el.on "click", (e)=> e.stopPropagation()

  showOptions : () ->
    @$dropDown = $ dropDown( {options:@options} )
    $('body').append( @$dropDown).css overflow: "hidden"
    castShadows @$dropDown
    @$checkmark = $ '.checkmark', @$dropDown

    @sizeAndPositionDropdown()

    $(document).on 'mouseup', (e)=>
      # Allow 1/3 of a second after the mousepress in case
      # they're single clicking to open the dropdown
      return if Date.now() - @openTime < 325

      # Mouseup occurs outside the dropdown
      if $(e.target).closest(".drop-down").length == 0
        @hideOptions()

      $target = $(e.target)

      # If release occurs over a valid option
      if $target.is(".option")
        @onOptionClicked $target

    $option = $(".option", @$dropDown)
    $option.on 'mouseover', (e)=> $(e.currentTarget).addClass 'focus'
    $option.on 'mouseout', (e)=>  $(e.currentTarget).removeClass 'focus'
    @addCheckToActiveOption()

  sizeAndPositionDropdown : () ->
    dropdownHeight = @$dropDown.outerHeight()
    pos            = @$el.offset()
    winHeight      = $(window).height()

    # If dropdown would bleed off bottom of page
    if pos.top + dropdownHeight > winHeight
      top = winHeight - dropdownHeight
    else
      top = pos.top

    # If page is smaller than dropdown
    if winHeight < dropdownHeight
      top = 0
      @$dropDown.css {height: winHeight; overflow: 'scroll'}

    @$dropDown.css {top: top, left: pos.left}

  onOptionClicked : ($target) ->
    @activeOptionId = $target.attr 'data-id'
    @addCheckToActiveOption()
    $target.addClass 'clicked'
    @onChangeCb @activeOptionId
    setTimeout ()=>
      $target.removeClass 'clicked'
      setTimeout ()=>
        @hideOptions()
      , 30
    , 80

  hideOptions : () ->
    # if DropDown.activeDropDown == @ then DropDown.activeDropDown = null
    $(".option", @$dropDown).off( 'mouseover')
                            .off 'mouseout'
    @$dropDown?.remove()
    $('body').css overflow: "initial"
    $(document).off 'mouseup'

  addCheckToActiveOption : ()->
    if !@activeOptionId?
      $option = $(".option", @$dropDown).first()
    else
      $option = $(".option[data-id='#{@activeOptionId}']", @$dropDown)

    $option.append @$checkmark
    @$el.text $option.text()

  destroy : () ->
    @$el.off()
    @$el.empty()
    $(".option", @$el).off()

  # ------------------------------------ Helpers

  getSelectedOptionName : (options) ->
    for option in options
      # If we haven't found any options yet, and this is not a label, save as default
      if !firstOptionIsFound && !option.isLabel
        firstOptionIsFound = true
        defaultOption = option

      if option.selected
        @activeOptionId = option.id
        return option.name
    #  We didnt find any options that were selected, so return the first option in the list
    return defaultOption.name
