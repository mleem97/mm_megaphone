fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'MLeeM'
description 'A FiveM addon that allows players with a police job to use a megaphone in vehicles.'
version '1.3.0'

-- Dependency: pma-voice is required. Compatible with v6.6.2+ and pma-voice v7.x pre-releases.
dependency 'pma-voice'
-- Optional: specify a minimum pma-voice version if desired
-- dependency 'pma-voice' '>= 6.6.2'

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
