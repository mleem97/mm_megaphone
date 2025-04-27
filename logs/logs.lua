-- Log-System für Megaphon-Nutzung

local logFile = "c:/Users/marvi/Documents/GitHub/mm_megaphone/logs/megaphone.log"

function LogMegaphoneUsage(playerId, action)
    local playerName = GetPlayerName(playerId)
    local logEntry = string.format("[%s] Player: %s (ID: %d) - %s\n", os.date("%Y-%m-%d %H:%M:%S"), playerName, playerId, action)

    SaveResourceFile(GetCurrentResourceName(), logFile, logEntry, -1)
end