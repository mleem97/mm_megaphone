local useSubmix = true
dofile('bridge/framework.lua')

local megaphoneSubmix

-- CLIENT: Submix erstellen und anwenden
function ApplyMegaphoneSubmix()
    if not megaphoneSubmix then
        megaphoneSubmix = CreateAudioSubmix('Megaphone')
        SetAudioSubmixEffectRadioFx(megaphoneSubmix, 0)
        SetAudioSubmixEffectParamInt(megaphoneSubmix, 0, `default`, 1)
        SetAudioSubmixEffectParamFloat(megaphoneSubmix, 0, `freq_low`, 300.0)
        SetAudioSubmixEffectParamFloat(megaphoneSubmix, 0, `freq_hi`, 3000.0)
        SetAudioSubmixEffectParamFloat(megaphoneSubmix, 0, `rm_mod_freq`, 100.0)
        SetAudioSubmixEffectParamFloat(megaphoneSubmix, 0, `rm_mix`, 0.5)
        AddAudioSubmixOutput(megaphoneSubmix, 0)
    end
    MumbleSetAudioInputIntent("speech")
    MumbleSetSubmixForServerId(PlayerId(), megaphoneSubmix)
end

function RemoveMegaphoneSubmix()
    if megaphoneSubmix then
        MumbleSetSubmixForServerId(PlayerId(), -1)
    end
end

RegisterNetEvent("mm_megaphone:applySubmix", ApplyMegaphoneSubmix)
RegisterNetEvent("mm_megaphone:removeSubmix", RemoveMegaphoneSubmix)

RegisterCommand("+carMegaphone", function()
    if CanUseCarMegaphone() then
        if useSubmix then
            TriggerServerEvent("mm_megaphone:applySubmix")
        end
        exports["pma-voice"]:overrideProximityRange(50.0, true)
    end
end)

RegisterCommand("-carMegaphone", function()
    if CanUseCarMegaphone() then
        if useSubmix then
            TriggerServerEvent("mm_megaphone:removeSubmix")
        end
        exports["pma-voice"]:clearProximityOverride()
    end
end)

RegisterKeyMapping('+carMegaphone', 'Car Megaphone', 'keyboard', '')

-- SERVER: Submix-Events weiterleiten
if IsDuplicityVersion() then
    RegisterNetEvent("mm_megaphone:applySubmix", function()
        TriggerClientEvent("mm_megaphone:applySubmix", source)
    end)
    RegisterNetEvent("mm_megaphone:removeSubmix", function()
        TriggerClientEvent("mm_megaphone:removeSubmix", source)
    end)
end
