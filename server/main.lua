-- MLeeM's Car Megaphone - Server-Logik

RegisterNetEvent('mm_megaphone:applySubmix', function()
    local src = source

    -- Server-side validation: prüfe Job/Berechtigung bevor Submix angewendet wird
    local allowed = false
    local ok, err = pcall(function()
        -- Config is a shared script, so Config.AllowedJobs should be available on server
        local allowedJobs = Config and Config.AllowedJobs or { 'police' }

        -- ESX
        if GetResourceState('es_extended') == 'started' then
            local ESX = exports['es_extended']:getSharedObject()
            if ESX and ESX.GetPlayerFromId then
                local xPlayer = ESX.GetPlayerFromId(src)
                if xPlayer and xPlayer.job and xPlayer.job.name then
                    for _, j in ipairs(allowedJobs) do if xPlayer.job.name == j then allowed = true; break end end
                end
            end
        end

        -- QBCore
        if not allowed and GetResourceState('qb-core') == 'started' then
            local QBCore = exports['qb-core']:GetCoreObject()
            if QBCore and QBCore.GetPlayer then
                local ply = QBCore.GetPlayer(src)
                if ply and ply.PlayerData and ply.PlayerData.job and ply.PlayerData.job.name then
                    for _, j in ipairs(allowedJobs) do if ply.PlayerData.job.name == j then allowed = true; break end end
                end
            end
        end
    end)

    if not ok then
        print(('^1[mm_megaphone] Error during server-side validation: %s'):format(tostring(err)))
    end

    if not allowed then
        print(('^3[mm_megaphone] Player %s attempted to apply submix without permission'):format(src))
        return
    end

    TriggerClientEvent('mm_megaphone:applySubmix', src)
    if LogMegaphoneUsage then LogMegaphoneUsage(src, 'Megaphone aktiviert') end
end)

RegisterNetEvent('mm_megaphone:removeSubmix', function()
    local src = source
    -- Remove submix - no additional validation required for removing
    TriggerClientEvent('mm_megaphone:removeSubmix', src)
    if LogMegaphoneUsage then LogMegaphoneUsage(src, 'Megaphone deaktiviert') end
end)
