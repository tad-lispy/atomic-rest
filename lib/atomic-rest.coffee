cson    = require 'cson-safe'
request = require 'request'

module.exports =
  activate: ->
    atom.workspaceView.command "atomic-rest:request", => do @request

  request: ->
    # This assumes the active pane item is an editor
    # Get request block
    editor = atom.workspace.activePaneItem

    # TODO: Autmoatic range selector. For now we take user selection
    # range  = editor.getCurrentParagraphBufferRange()
    # block  = editor.getTextInBufferRange range
    block  = editor.getSelectedText().split '\n'
    target = block
      .shift()
      .match ///
        (GET|POST|PUT|DELETE|HEAD|PATCH|OPTION)
        \s+
        (\S+)
      ///
    if not target then return console.log "Not a request block."
    method = target[1]
    url    = target[2]
    body   = block.join '\n'

    if body?.trim() then json = cson.parse body

    request {
      method
      url
      json
    }, (error, response, body) =>
      try body = cson.stringify JSON.parse(body), null, 2
      catch error
        console.log "Can't parse body as a JSON. Will show raw."

      headers = cson.stringify response.headers, null, 2

      editor.moveCursorToEndOfLine()
      editor.insertText """


        ### Response
        # Headers:
        #{headers}
        # Body:
        #{body}
        ###

      """
