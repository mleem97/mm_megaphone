-- MLeeM's Car Megaphone - Client-Hauptlogik

-- Einstellungen
local isActive, isCooldown = false, false
local lastPress = 0

-- Range / Toggle state
local currentRangeIndex = 1
local currentRange = Config.MegaphoneRange or 50.0

-- Helper: initialize currentRangeIndex from Config
local function initRangeFromConfig()
    if type(Config.RangePresets) == 'table' and #Config.RangePresets > 0 then
        -- pick default index if available
        if Config.DefaultRangeIndex and Config.RangePresets[Config.DefaultRangeIndex] then
            currentRangeIndex = Config.DefaultRangeIndex
        else
            -- find nearest to Config.MegaphoneRange
            local bestDiff, bestIdx = math.huge, 1
            for i, v in ipairs(Config.RangePresets) do
                local diff = math.abs((Config.MegaphoneRange or 0) - v)
                if diff < bestDiff then bestDiff, bestIdx = diff, i end
            end
            currentRangeIndex = bestIdx
        end
        currentRange = Config.RangePresets[currentRangeIndex]
    else
        currentRangeIndex = 1
        currentRange = Config.MegaphoneRange or 50.0
    end
end

local function setMegaphoneRangeByIndex(idx)
    if not Config.RangePresets or #Config.RangePresets == 0 then return end
    idx = ((idx - 1) % #Config.RangePresets) + 1
    currentRangeIndex = idx
    currentRange = Config.RangePresets[currentRangeIndex]
    -- Update runtime value used for override
    Config.MegaphoneRange = currentRange
    if isActive then
        local ok, err = pcall(function()
            exports['pma-voice']:overrideProximityRange(currentRange, true)
        end)
        if not ok then print('^1[mm_megaphone] Error setting range: '..tostring(err)) end
    end
    ShowNotification(('Megaphone range set to %sm'):format(currentRange))
end

local function cycleMegaphoneRange()
    if not Config.RangePresets or #Config.RangePresets == 0 then
        ShowNotification('No range presets configured')
        return
    end
    setMegaphoneRangeByIndex(currentRangeIndex + 1)
end

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

    local success, err = pcall(function()
        if Config.UseSubmix then
            TriggerServerEvent('mm_megaphone:applySubmix')
        end
        -- pma-voice: override proximity range (third arg true for temporary override)
        exports['pma-voice']:overrideProximityRange(currentRange, true)
    end)

    if not success then
        print("^1[mm_megaphone] Error activating megaphone: " .. tostring(err))
        return
    end

    isActive = true
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
    if Config.ToggleMode then
        -- Toggle behaviour: press to toggle on/off
        if isActive then
            DeactivateMegaphone()
        else
            ActivateMegaphone()
        end
    else
        ActivateMegaphone()
    end
end, false)
RegisterCommand('-carMegaphone', function()
    -- Only deactivate on key release when not in ToggleMode
    if not Config.ToggleMode then
        DeactivateMegaphone()
    end
end, false)
RegisterKeyMapping('+carMegaphone', 'Car Megaphone', 'keyboard', Config.ActivationKey or '')

-- Command to cycle through range presets
RegisterCommand('carMegaphoneCycleRange', function()
    cycleMegaphoneRange()
end, false)
RegisterKeyMapping('carMegaphoneCycleRange', 'Cycle Megaphone Range', 'keyboard', '')

-- Überwache, ob Bedingungen noch erfüllt sind (dynamisches Sleep)
Citizen.CreateThread(function()
    initRangeFromConfig()
    while true do
        if isActive and not CanUseCarMegaphone() then
            DeactivateMegaphone()
        end
        Citizen.Wait(isActive and 500 or 2000) -- längere Pause wenn inaktiv
    end
end)