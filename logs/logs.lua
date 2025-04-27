--[[
    MLeeM's Car Megaphone - Log-System
    Dieses Skript enthält die Funktionen zum Loggen von Megaphon-Aktivitäten.
]]--

local logFile = "logs/megaphone.log" -- Relativer Pfad zur Log-Datei

-- Funktion: Megaphon-Nutzung loggen
function LogMegaphoneUsage(playerId, action)
    -- Spielerinformationen sammeln
    local playerName = GetPlayerName(playerId) or "Unknown"
    local playerIdentifiers = GetPlayerIdentifiers(playerId) or {}
    local steam = "Unknown"
    local license = "Unknown"
    
    -- Identifiers extrahieren
    for _, identifier in pairs(playerIdentifiers) do
        if string.find(identifier, "steam:") then
            steam = identifier
        elseif string.find(identifier, "license:") then
            license = identifier
        end
    end
    
    -- Log-Eintrag erstellen
    local logEntry = string.format(
        "[%s] Player: %s (ID: %d, Steam: %s, License: %s) - %s\n", 
        os.date("%Y-%m-%d %H:%M:%S"), 
        playerName, 
        playerId, 
        steam, 
        license, 
        action
    )
    
    -- In Konsole ausgeben
    print("^3[MEGAPHONE LOG] ^7" .. playerName .. " (" .. playerId .. "): " .. action)
    
    -- In Datei speichern
    local currentLog = LoadResourceFile(GetCurrentResourceName(), logFile) or ""
    SaveResourceFile(GetCurrentResourceName(), logFile, currentLog .. logEntry, -1)
end