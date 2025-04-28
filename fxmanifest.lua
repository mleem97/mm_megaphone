fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'MLeeM'
description 'Ein FiveM-Addon, das Spielern mit Polizeijob erlaubt, ein Megafon im Fahrzeug zu benutzen.'
version '1.1.0'

dependency 'pma-voice'

shared_scripts {
    'config/config.lua'
}

client_scripts {
    'bridge/framework.lua',
    'client/main.lua',
    'client/submix.lua'
}

server_scripts {
    'server/main.lua',
    'logs/logs.lua'
}
