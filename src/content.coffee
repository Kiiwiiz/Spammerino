Spammerino = window.Spammerino ?= {}

injectFunction = (f) ->
  injectCode '(' + f + ')()'

injectCode = (code) ->
  script = document.createElement 'script'
  script.textContent = code
  (document.head||document.documentElement).appendChild script
  script.remove()

injectFile = (fileName) ->
  script = document.createElement 'script'
  script.src = chrome.extension.getURL fileName
  script.onload = -> @remove()
  (document.head || document.documentElement).appendChild script

new Promise (success) ->
  Spammerino.initConfig success
.then ->
  injectCode 'window.Spammerino = ' + JSON.stringify Spammerino
  injectFile 'js/clipboard.js'
  injectFile 'js/twitch.js'
  injectFile 'js/spammerino.js'
