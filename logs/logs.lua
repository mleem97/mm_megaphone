-- MLeeM's Car Megaphone - Log-System

local logFile = "logs/megaphone.log"

function LogMegaphoneUsage(playerId, action)
    local playerName = GetPlayerName(playerId) or "Unknown"
    local playerIdentifiers = GetPlayerIdentifiers(playerId) or {}
    local steam, license = "Unknown", "Unknown"
    for _, identifier in pairs(playerIdentifiers) do
        if string.find(identifier, "steam:") then steam = identifier end
        if string.find(identifier, "license:") then license = identifier end
    end
    local logEntry = string.format("[%s] Player: %s (ID: %d, Steam: %s, License: %s) - %s\n",
        os.date("%Y-%m-%d %H:%M:%S"), playerName, playerId, steam, license, action)
    print("[MEGAPHONE LOG] " .. playerName .. " (" .. playerId .. "): " .. action)
    local currentLog = LoadResourceFile(GetCurrentResourceName(), logFile) or ""
    SaveResourceFile(GetCurrentResourceName(), logFile, currentLog .. logEntry, -1)
end