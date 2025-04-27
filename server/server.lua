--[[
    MLeeM's Car Megaphone - Server-Skript
    Dieses Skript enthält die serverseitige Logik des Megaphon-Systems.
]]--

-- Lokale Variablen
local activeMegaphoneUsers = {}

-- Submix anwenden
RegisterNetEvent("mm_megaphone:applySubmix", function()
    local playerId = source
    
    -- Optional: Serverseitige Überprüfung durchführen
    -- (Nicht implementiert, da pma-voice selbst keine Serverside-Events bietet)
    
    -- Aktivierung speichern
    activeMegaphoneUsers[playerId] = true
    
    -- Event an alle Clients weiterleiten
    TriggerClientEvent("mm_megaphone:applySubmix", playerId)
    
    -- Aktivierung loggen
    LogMegaphoneUsage(playerId, "Megaphone activated")
end)

-- Submix entfernen
RegisterNetEvent("mm_megaphone:removeSubmix", function()
    local playerId = source
    
    -- Aktivierung entfernen
    activeMegaphoneUsers[playerId] = nil
    
    -- Event an alle Clients weiterleiten
    TriggerClientEvent("mm_megaphone:removeSubmix", playerId)
    
    -- Deaktivierung loggen
    LogMegaphoneUsage(playerId, "Megaphone deactivated")
end)

-- Player Disconnect Event
AddEventHandler('playerDropped', function()
    local playerId = source
    
    -- Wenn der Spieler das Megaphon aktiv hatte, Status zurücksetzen
    if activeMegaphoneUsers[playerId] then
        activeMegaphoneUsers[playerId] = nil
        LogMegaphoneUsage(playerId, "Megaphone reset (player disconnected)")
    end
end)

-- Resource Start Event
AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        -- Prüfen, ob pma-voice vorhanden ist
        if GetResourceState('pma-voice') ~= 'started' then
            print("^1[WARNING] ^7pma-voice ist nicht gestartet. MLeeM's Car Megaphone benötigt pma-voice, um zu funktionieren!")
        end
        
        print("^2[INFO] ^7MLeeM's Car Megaphone wurde gestartet. Nutze /setMegaphoneVolume [low/normal/high] zur Lautstärkeeinstellung.")
    end
end)