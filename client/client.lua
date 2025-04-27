--[[
    MLeeM's Car Megaphone - Client-Hauptskript
    Dieses Skript enthält die Hauptlogik des Megaphon-Systems.
]]--

-- Lokale Variablen
local isMegaphoneActive = false
local isOnCooldown = false
local currentVolumeLevel = Config.DefaultVolume

-- Funktion: Megaphon aktivieren
function ActivateMegaphone()
    if isOnCooldown then
        ShowNotification(Config.Messages.CooldownActive)
        return
    end
    
    if not CanUseCarMegaphone() then
        -- Überprüfung fehlgeschlagen - nicht anzeigen, um Spam zu vermeiden
        return
    end
    
    -- Megaphon aktivieren
    isMegaphoneActive = true
    
    -- Audio-Effekte anwenden
    if Config.UseSubmix then
        TriggerServerEvent("mm_megaphone:applySubmix")
    end
    
    -- Reichweite erhöhen
    exports["pma-voice"]:overrideProximityRange(Config.VolumeLevels[currentVolumeLevel], true)
    
    -- Aktivierungssound abspielen
    PlaySoundFrontend(-1, "CONFIRM_BEEP", "HUD_MINI_GAME_SOUNDSET", true)
    
    -- Visuelle Effekte aktivieren
    if Config.UseVisualEffects then
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
        if vehicle ~= 0 then
            ActivateVisualEffects(vehicle)
        end
    end
    
    -- Optional: Benachrichtigung anzeigen
    ShowNotification(Config.Messages.MegaphoneActivated)
    
    -- Cooldown setzen
    if Config.CooldownTime > 0 then
        isOnCooldown = true
        Citizen.SetTimeout(Config.CooldownTime, function()
            isOnCooldown = false
        end)
    end
end

-- Funktion: Megaphon deaktivieren
function DeactivateMegaphone()
    if not isMegaphoneActive then return end
    
    isMegaphoneActive = false
    
    -- Audio-Effekte entfernen
    if Config.UseSubmix then
        TriggerServerEvent("mm_megaphone:removeSubmix")
    end
    
    -- Reichweite zurücksetzen
    exports["pma-voice"]:clearProximityOverride()
    
    -- Visuelle Effekte deaktivieren
    if Config.UseVisualEffects then
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
        if vehicle ~= 0 then
            DeactivateVisualEffects(vehicle)
        end
    end
    
    -- Optional: Benachrichtigung anzeigen
    ShowNotification(Config.Messages.MegaphoneDeactivated)
end

-- Funktion: Visuelle Effekte aktivieren
function ActivateVisualEffects(vehicle)
    SetVehicleLights(vehicle, 2) -- Lichter blinken lassen
    SetVehicleIndicatorLights(vehicle, 0, true)
    SetVehicleIndicatorLights(vehicle, 1, true)
end

-- Funktion: Visuelle Effekte deaktivieren
function DeactivateVisualEffects(vehicle)
    SetVehicleLights(vehicle, 0)
    SetVehicleIndicatorLights(vehicle, 0, false)
    SetVehicleIndicatorLights(vehicle, 1, false)
end

-- Commands registrieren
RegisterCommand("+carMegaphone", function()
    ActivateMegaphone()
end, false)

RegisterCommand("-carMegaphone", function()
    DeactivateMegaphone()
end, false)

-- Lautstärke ändern
RegisterCommand("setMegaphoneVolume", function(_, args)
    local level = args[1]
    if Config.VolumeLevels[level] then
        currentVolumeLevel = level
        ShowNotification(Config.Messages.VolumeSet .. level)
        
        -- Wenn Megaphon aktiv ist, die Reichweite sofort aktualisieren
        if isMegaphoneActive then
            exports["pma-voice"]:overrideProximityRange(Config.VolumeLevels[currentVolumeLevel], true)
        end
    else
        ShowNotification(Config.Messages.InvalidVolume)
    end
end, false)

-- Tastenbelegung registrieren
RegisterKeyMapping('+carMegaphone', 'Car Megaphone', 'keyboard', '')

-- Thread für kontinuierliche Überprüfungen (z.B. Fahrzeug verlassen)
CreateThread(function()
    while true do
        if isMegaphoneActive then
            -- Wenn Megaphon aktiv ist, aber die Bedingungen nicht mehr erfüllt sind
            if not CanUseCarMegaphone() then
                DeactivateMegaphone()
            end
            Wait(500) -- Häufigere Überprüfung, wenn aktiv
        else
            Wait(1000) -- Längere Pause, wenn inaktiv
        end
    end
end)