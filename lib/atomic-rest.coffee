AtomicRestView = require './atomic-rest-view'

module.exports =
  atomicRestView: null

  activate: (state) ->
    @atomicRestView = new AtomicRestView(state.atomicRestViewState)

  deactivate: ->
    @atomicRestView.destroy()

  serialize: ->
    atomicRestViewState: @atomicRestView.serialize()
