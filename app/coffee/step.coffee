module.exports = class Step

  constructor: () ->
  getTitle   : () -> console.log 'Overwrite `getTitle` in extending class'
  destroy    : () ->
  activate   : () -> # Some steps use it, most don't
  deactivate : () -> # Some steps use it, most don't
