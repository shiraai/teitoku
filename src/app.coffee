app = require 'app'
BrowserWindow = require 'browser-window'

# globals
global.mainWindow = mainWindow = null

require('crash-reporter').start()

# quit
app.on 'window-all-closed', ->
   if process.platform != 'darwin'
      app.quit()

# pepperflash
if process.platform == 'linux'
   app.commandLine.appendSwitch 'ppapi-flash-path', '/usr/lib/PepperFlash/libpepflashplayer.so'
   app.commandLine.appendSwitch 'ppapi-flash-version', '17.0.0.169'
else if process.platform == 'win32'
   app.commandLine.appendSwitch 'ppapi-flash-path', __dirname + '/PepperFlash/win32/pepflashplayer32.dll'
   app.commandLine.appendSwitch 'ppapi-flash-version', '19.0.0.128'

app.on 'ready', ->
   global.mainWindow = mainWindow = new BrowserWindow
      'width'  : 811
      'height' : 540
      'frame'  : false
      'web-preferences':
         'plugins': true
         
   mainWindow.loadUrl "file://#{__dirname}/index.html"