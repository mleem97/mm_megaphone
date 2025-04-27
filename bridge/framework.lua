--[[
    MLeeM's Car Megaphone - Framework Bridge
    Dieses Skript erkennt automatisch das verwendete Framework und bietet Wrapper-Funktionen.
]]--

local Framework, playerJob

-- Framework-Erkennung
local function DetectFramework()
    if GetResourceState('es_extended') == 'started' then
        Framework = 'esx'
        ESX = exports["es_extended"]:getSharedObject()
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
    return false
end

-- Wrapper-Funktion: Spieler-Job abrufen
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

-- Framework-Events registrieren
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

-- Job kontinuierlich aktualisieren
CreateThread(function()
    -- Warten bis Framework erkannt wurde
    while not DetectFramework() do
        Wait(100)
    end
    
    -- Framework-Events registrieren
    RegisterFrameworkEvents()
    
    -- Job initial abrufen
    Wait(1000) -- Kurz warten, bis Spielerdaten geladen sind
    playerJob = GetPlayerJob()
    
    -- Job periodisch aktualisieren (als Fallback)
    while true do
        if Framework ~= 'standalone' then
            playerJob = GetPlayerJob()
        end
        Wait(10000) -- Alle 10 Sekunden aktualisieren (Performance-optimiert)
    end
end)

-- Wrapper-Funktion: Prüfen, ob Spieler in einem erlaubten Fahrzeug sitzt
function IsPlayerInAllowedVehicle()
    local ped = PlayerPedId()
    if not IsPedInAnyVehicle(ped, false) then return false end
    
    local veh = GetVehiclePedIsIn(ped, false)
    if veh == 0 then return false end
    
    -- Prüfen, ob Spieler Fahrer ist
    if GetPedInVehicleSeat(veh, -1) ~= ped then return false end
    
    -- Fahrzeugklasse prüfen
    if #Config.AllowedVehicleClasses > 0 then
        local vehClass = GetVehicleClass(veh)
        for _, class in ipairs(Config.AllowedVehicleClasses) do
            if vehClass == class then
                return true
            end
        end
    end
    
    -- Fahrzeugmodell prüfen (falls keine Klasse gefunden wurde)
    local model = GetDisplayNameFromVehicleModel(GetEntityModel(veh)):lower()
    for _, allowedModel in ipairs(Config.AllowedVehicleModels) do
        if model == allowedModel:lower() then
            return true
        end
    end
    
    return false
end

-- Wrapper-Funktion: Prüfen, ob Spieler einen erlaubten Job hat
function IsPlayerInAllowedJob()
    if Framework == 'standalone' then return true end -- Im Standalone-Modus immer erlauben
    
    for _, job in ipairs(Config.AllowedJobs) do
        if playerJob == job then
            return true
        end
    end
    return false
end

-- Hauptprüfungsfunktion: Darf der Spieler das Megaphon benutzen?
function CanUseCarMegaphone()
    return IsPlayerInAllowedVehicle() and IsPlayerInAllowedJob()
end

-- Wrapper-Funktion: Benachrichtigung anzeigen
function ShowNotification(message)
    if Framework == 'esx' then
        ESX.ShowNotification(message)
    elseif Framework == 'qb' then
        QBCore.Functions.Notify(message)
    elseif Framework == 'ox' and lib.notify then
        lib.notify({description = message})
    else
        -- Fallback: Native FiveM Benachrichtigung
        SetNotificationTextEntry("STRING")
        AddTextComponentString(message)
        DrawNotification(false, false)
    end
end