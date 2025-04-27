-- Framework-Bridge für Megaphon-Script

local Framework, playerJob

local Config = require('config.config') -- Konfigurationsdatei laden

-- Framework-Erkennung
if GetResourceState('es_extended') == 'started' then
    Framework = 'esx'
    ESX = exports["es_extended"]:getSharedObject()
elseif GetResourceState('qb-core') == 'started' then
    Framework = 'qb'
    QBCore = exports['qb-core']:GetCoreObject()
elseif GetResourceState('ox_core') == 'started' then
    Framework = 'ox'
    lib = exports.ox_lib
else
    Framework = 'standalone'
end

function GetPlayerJob()
    if Framework == 'esx' then
        return ESX.GetPlayerData().job and ESX.GetPlayerData().job.name or nil
    elseif Framework == 'qb' then
        return QBCore.Functions.GetPlayerData().job and QBCore.Functions.GetPlayerData().job.name or nil
    elseif Framework == 'ox' then
        local player = lib.getPlayer()
        return player and player.job and player.job.name or nil
    else
        return nil
    end
end

RegisterNetEvent('esx:setJob', function(job)
    if Framework == 'esx' then playerJob = job.name end
end)
RegisterNetEvent('QBCore:Client:OnJobUpdate', function(job)
    if Framework == 'qb' then playerJob = job.name end
end)
RegisterNetEvent('ox:playerJobUpdated', function(job)
    if Framework == 'ox' then playerJob = job.name end
end)

CreateThread(function()
    while true do
        if Framework ~= 'standalone' then
            playerJob = GetPlayerJob()
        end
        Wait(1000)
    end
end)

function CanUseCarMegaphone()
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped, false)
    if veh ~= 0 then
        local vehClass = GetVehicleClass(veh)
        if vehClass == 18 and IsPlayerInAllowedJob() then
            return true
        end
    end
    return false
end

function IsPlayerInAllowedJob()
    for _, job in ipairs(Config.AllowedJobs) do
        if playerJob == job then
            return true
        end
    end
    return false
end