-- MLeeM's Car Megaphone - Framework Bridge
-- Erkennt ESX, QBCore, ox_core oder Standalone und kapselt Job-/Notify-Logik

local Framework, playerJob

local function DetectFramework()
    if GetResourceState('es_extended') == 'started' then
        Framework = 'esx'
        ESX = exports['es_extended']:getSharedObject()
        return true
    elseif GetResourceState('qb-core') == 'started' then
        Framework = 'qb'
        QBCore = exports['qb-core']:GetCoreObject()
        return true
    elseif GetResourceState('ox_core') == 'started' then
        Framework = 'ox'
        lib = exports.ox_lib
        return true
    else
        Framework = 'standalone'
        return true
    end
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

function RegisterFrameworkEvents()
    if Framework == 'esx' then
        RegisterNetEvent('esx:setJob', function(job)
            playerJob = job.name
        end)
    elseif Framework == 'qb' then
        RegisterNetEvent('QBCore:Client:OnJobUpdate', function(job)
            playerJob = job.name
        end)
    elseif Framework == 'ox' then
        RegisterNetEvent('ox:playerJobUpdated', function(job)
            playerJob = job.name
        end)
    end
end

CreateThread(function()
    while not DetectFramework() do Wait(100) end
    RegisterFrameworkEvents()
    Wait(1000)
    playerJob = GetPlayerJob()
    while true do
        if Framework ~= 'standalone' then
            playerJob = GetPlayerJob()
        end
        Wait(10000)
    end
end)

function IsPlayerInAllowedVehicle()
    local ped = PlayerPedId()
    if not IsPedInAnyVehicle(ped, false) then return false end
    local veh = GetVehiclePedIsIn(ped, false)
    if veh == 0 then return false end
    if GetPedInVehicleSeat(veh, -1) ~= ped then return false end
    if #Config.AllowedVehicleClasses > 0 then
        local vehClass = GetVehicleClass(veh)
        for _, class in ipairs(Config.AllowedVehicleClasses) do
            if vehClass == class then return true end
        end
    end
    local model = GetDisplayNameFromVehicleModel(GetEntityModel(veh)):lower()
    for _, allowedModel in ipairs(Config.AllowedVehicleModels) do
        if model == allowedModel:lower() then return true end
    end
    return false
end

function IsPlayerInAllowedJob()
    if Framework == 'standalone' then return true end
    for _, job in ipairs(Config.AllowedJobs) do
        if playerJob == job then return true end
    end
    return false
end

function CanUseCarMegaphone()
    return IsPlayerInAllowedVehicle() and IsPlayerInAllowedJob()
end

function ShowNotification(msg)
    if Framework == 'esx' then
        ESX.ShowNotification(msg)
    elseif Framework == 'qb' then
        QBCore.Functions.Notify(msg)
    elseif Framework == 'ox' and lib.notify then
        lib.notify({description = msg})
    else
        SetNotificationTextEntry('STRING')
        AddTextComponentString(msg)
        DrawNotification(false, false)
    end
end