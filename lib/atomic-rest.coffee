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
      if typeof body is 'object'
        body = cson.stringify body
      else
        try body = cson.stringify JSON.parse(body), null, 2
        catch error
          console.log "Can't parse body as a JSON. Will show raw."

      headers = cson.stringify response.headers, null, 2

      # Position cursor after selection (at response insert position).
      selectedRange = editor.getSelectedScreenRange()
      editor.setCursorScreenPosition(selectedRange.end)

      # Removing previous response.
      ranges = editor.getSelectedBufferRanges()
      try
        editor.selectToBottom()
        searchRange = editor.getSelectedBufferRange()

        # Limit response search up to next request block (if present).
        editor.scanInBufferRange(
          /(GET|POST|PUT|DELETE|HEAD|PATCH|OPTION)[\t ]+(\S+)/, searchRange, (match) =>
              searchRange = searchRange.copy()
              searchRange.end = match.range.copy().start
              match.stop()
        )

        # Find previous response and replace with empty string.
        editor.scanInBufferRange(
          /\s+### Response\s+# Headers:[\s\S]*?\s+# Body:[\s\S]*?\s+###\s+/, searchRange, (match) =>
              match.replace("")
        )
      finally
        editor.setSelectedBufferRanges(ranges)

      # Adding current response.
      try
        editor.insertText """


        ### Response
        # Headers:
        #{headers}
        # Body:
        #{body}
        ###


        """
      finally
        # Position cursor at the beginning of the request block.
        editor.setCursorScreenPosition(selectedRange.start)
