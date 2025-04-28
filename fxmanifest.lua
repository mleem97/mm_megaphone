fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'MLeeM'
description 'A FiveM addon that allows players with a police job to use a megaphone in vehicles.'
version '1.2.0'

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
