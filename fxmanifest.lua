--[[
    MLeeM's Car Megaphone - Resource Manifest
    Definiert die Resource-Eigenschaften und Abhängigkeiten.
]]--

fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'MLeeM'
description 'Ein FiveM-Addon, das Spielern mit Polizeijob erlaubt, ein Megafon im Fahrzeug zu benutzen'
version '1.0.0'

-- Dateien
client_scripts {
    'config/config.lua',
    'bridge/framework.lua',
    'client/submix.lua',
    'client/client.lua'
}

server_scripts {
    'config/config.lua',
    'logs/logs.lua',
    'server/server.lua'
}

-- Abhängigkeiten
dependency 'pma-voice'

-- Export für andere Ressourcen
exports {
    'CanUseCarMegaphone',
    'ActivateMegaphone',
    'DeactivateMegaphone'
}
