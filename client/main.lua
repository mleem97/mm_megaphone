-- MLeeM's Car Megaphone - Client-Hauptlogik

-- Einstellungen
local isActive, isCooldown = false, false
local lastPress = 0

-- Visuelle Effekte
local function ActivateVisual(vehicle)
    SetVehicleLights(vehicle, 2)
    SetVehicleIndicatorLights(vehicle, 0, true)
    SetVehicleIndicatorLights(vehicle, 1, true)
end
local function DeactivateVisual(vehicle)
    SetVehicleLights(vehicle, 0)
    SetVehicleIndicatorLights(vehicle, 0, false)
    SetVehicleIndicatorLights(vehicle, 1, false)
end

-- Megaphon aktivieren
function ActivateMegaphone()
    if isCooldown then
        ShowNotification(Config.Notifications.cooldown)
        return
    end
    if not CanUseCarMegaphone() then
        ShowNotification(Config.Notifications.not_allowed)
        return
    end
    isActive = true
    if Config.UseSubmix then
        TriggerServerEvent('mm_megaphone:applySubmix')
    end
    exports['pma-voice']:overrideProximityRange(Config.MegaphoneRange, true)
    ShowNotification(Config.Notifications.megaphone_on)
    local veh = GetVehiclePedIsIn(PlayerPedId(), false)
    if Config.UseVisualEffects and veh ~= 0 then ActivateVisual(veh) end
    isCooldown = true
    Citizen.SetTimeout(Config.Cooldown, function() isCooldown = false end)
end

-- Megaphon deaktivieren
function DeactivateMegaphone()
    if not isActive then return end
    isActive = false
    if Config.UseSubmix then
        TriggerServerEvent('mm_megaphone:removeSubmix')
    end
    exports['pma-voice']:clearProximityOverride()
    ShowNotification(Config.Notifications.megaphone_off)
    local veh = GetVehiclePedIsIn(PlayerPedId(), false)
    if Config.UseVisualEffects and veh ~= 0 then DeactivateVisual(veh) end
end

RegisterCommand('+carMegaphone', function()
    ActivateMegaphone()
end)
RegisterCommand('-carMegaphone', function()
    DeactivateMegaphone()
end)
RegisterKeyMapping('+carMegaphone', 'Car Megaphone', 'keyboard', Config.ActivationKey or '')

-- Überwache, ob Bedingungen noch erfüllt sind
CreateThread(function()
    while true do
        if isActive and not CanUseCarMegaphone() then
            DeactivateMegaphone()
        end
        Wait(isActive and 500 or 1000)
    end
end)