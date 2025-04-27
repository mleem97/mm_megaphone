local Config = require('config.config') -- Konfigurationsdatei laden

local useSubmix = Config.UseSubmix
local cooldown = false
local volumeLevels = Config.VolumeLevels
local currentVolume = Config.DefaultVolume

-- Funktion: Soundeffekt abspielen
function PlayActivationSound()
    PlaySoundFrontend(-1, "CONFIRM_BEEP", "HUD_MINI_GAME_SOUNDSET", true)
end

-- Funktion: Visuelle Effekte aktivieren
function ActivateVisualEffects(vehicle)
    SetVehicleLights(vehicle, 2) -- Lichter blinken lassen
    SetVehicleIndicatorLights(vehicle, 0, true)
    SetVehicleIndicatorLights(vehicle, 1, true)
end

function DeactivateVisualEffects(vehicle)
    SetVehicleLights(vehicle, 0)
    SetVehicleIndicatorLights(vehicle, 0, false)
    SetVehicleIndicatorLights(vehicle, 1, false)
end

-- Megaphon aktivieren
RegisterCommand("+carMegaphone", function()
    if cooldown then
        print(Config.Messages.CooldownActive)
        return
    end

    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)

    if vehicle ~= 0 and CanUseCarMegaphone() then
        cooldown = true
        PlayActivationSound()
        ActivateVisualEffects(vehicle)

        if useSubmix then
            TriggerServerEvent("mm_megaphone:applySubmix")
        end

        exports["pma-voice"]:overrideProximityRange(volumeLevels[currentVolume], true)

        -- Cooldown-Timer
        Citizen.SetTimeout(Config.CooldownTime, function()
            cooldown = false
        end)
    end
end)

-- Megaphon deaktivieren
RegisterCommand("-carMegaphone", function()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)

    if vehicle ~= 0 then
        DeactivateVisualEffects(vehicle)
    end

    if useSubmix then
        TriggerServerEvent("mm_megaphone:removeSubmix")
    end

    exports["pma-voice"]:clearProximityOverride()
end)

-- Lautstärke ändern
RegisterCommand("setMegaphoneVolume", function(_, args)
    local level = args[1]
    if volumeLevels[level] then
        currentVolume = level
        print("Megaphone volume set to: " .. level)
    else
        print("Invalid volume level. Use: low, normal, high.")
    end
end)

RegisterKeyMapping('+carMegaphone', 'Car Megaphone', 'keyboard', '')