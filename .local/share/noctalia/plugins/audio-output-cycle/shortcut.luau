shortcut.setLabel("Audio output")
shortcut.setIcon("switch-horizontal")
shortcut.setActive(false)
shortcut.setEnabled(true)

function onClick()
  noctalia.runAsync("cycle-audio-output")
end

function onRightClick()
  noctalia.runAsync("noctalia msg panel-open control-center audio")
end
