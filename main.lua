dofile('client/submix.lua') -- Submix-Logik auslagern

RegisterCommand("+carMegaphone", function()
    if CanUseCarMegaphone() then
        if useSubmix then
            TriggerServerEvent("mm_megaphone:applySubmix")
        end
        exports["pma-voice"]:overrideProximityRange(50.0, true)
    end
end, false)

RegisterCommand("-carMegaphone", function()
    if CanUseCarMegaphone() then
        if useSubmix then
            TriggerServerEvent("mm_megaphone:removeSubmix")
        end
        exports["pma-voice"]:clearProximityOverride()
    end
end, false)

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
