{View} = require 'atom'

module.exports =
class AtomicRestView extends View
  @content: ->
    @div class: 'atomic-rest overlay from-top', =>
      @div "The AtomicRest package is Alive! It's ALIVE!", class: "message"

  initialize: (serializeState) ->
    atom.workspaceView.command "atomic-rest:toggle", => @toggle()

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @detach()

  toggle: ->
    console.log "AtomicRestView was toggled!"
    if @hasParent()
      @detach()
    else
      atom.workspaceView.append(this)
