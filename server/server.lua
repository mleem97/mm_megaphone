local logFile = "c:/Users/marvi/Documents/GitHub/mm_megaphone/logs/megaphone.log"

-- Submix anwenden
RegisterNetEvent("mm_megaphone:applySubmix", function()
    TriggerClientEvent("mm_megaphone:applySubmix", source)
    LogMegaphoneUsage(source, "Submix applied")
end)

-- Submix entfernen
RegisterNetEvent("mm_megaphone:removeSubmix", function()
    TriggerClientEvent("mm_megaphone:removeSubmix", source)
    LogMegaphoneUsage(source, "Submix removed")
end)

-- Nutzung loggen
function LogMegaphoneUsage(playerId, action)
    local playerName = GetPlayerName(playerId)
    local logEntry = string.format("[%s] Player: %s (ID: %d) - %s\n", os.date("%Y-%m-%d %H:%M:%S"), playerName, playerId, action)

    SaveResourceFile(GetCurrentResourceName(), logFile, logEntry, -1)
end