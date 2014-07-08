{WorkspaceView} = require 'atom'
AtomicRest = require '../lib/atomic-rest'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "AtomicRest", ->
  activationPromise = null

  beforeEach ->
    atom.workspaceView = new WorkspaceView
    activationPromise = atom.packages.activatePackage('atomic-rest')

  describe "when the atomic-rest:toggle event is triggered", ->
    it "attaches and then detaches the view", ->
      expect(atom.workspaceView.find('.atomic-rest')).not.toExist()

      # This is an activation event, triggering it will cause the package to be
      # activated.
      atom.workspaceView.trigger 'atomic-rest:toggle'

      waitsForPromise ->
        activationPromise

      runs ->
        expect(atom.workspaceView.find('.atomic-rest')).toExist()
        atom.workspaceView.trigger 'atomic-rest:toggle'
        expect(atom.workspaceView.find('.atomic-rest')).not.toExist()
