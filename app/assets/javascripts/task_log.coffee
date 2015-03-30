from = 0
get_log = ->
  is_shown = $("#collapseLog").attr("aria-expanded")
  return if is_shown == 'false' or !is_shown
  $.getJSON window.location.href + '/log' + '?from=' + from, (data) ->
    content = $("#collapseLog > .well > pre")
    content.append(line + "<br>") for line in data.log
    from = data.to

setInterval get_log, 2000

