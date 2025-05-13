fzfcd Doskey
============
1. Im Regedit einen neuen Eintrag (Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Command Processor) namens AutoRun hinzufügen
2. Als Wert folgendes setzen >>doskey fzfcd=@for /f "delims=" %f in ('fzf') do @cd /d "%~dpf"<<

GlazeWM
=======
1. Installation: https://github.com/glzr-io/GlazeWM/release
2. Glaze und Zebar starten
3. Config File kopieren nach: %userprofile%\.glzr\glazewm\config.yaml
3. Manu Files kopieren nach: %userprofile%\.glzr\zebar\starter\...

   
nvim
====
1. Installieren
2. init.lua nach "C:\Users\xxx\AppData\Local\nvim\init.lua" kopieren

wezterm
=======
1. Installieren
2. .wezterm.lua nach "C:\Users\manue\.wezterm.lua" kopieren

yazi
====
1. Installieren
2. Theme ablegen unter roaming/yazi/config/theme.toml
