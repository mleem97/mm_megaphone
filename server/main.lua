-- MLeeM's Car Megaphone - Server-Logik

RegisterNetEvent('mm_megaphone:applySubmix', function()
    local src = source
    TriggerClientEvent('mm_megaphone:applySubmix', src)
    if LogMegaphoneUsage then LogMegaphoneUsage(src, 'Megaphone aktiviert') end
end)

RegisterNetEvent('mm_megaphone:removeSubmix', function()
    local src = source
    TriggerClientEvent('mm_megaphone:removeSubmix', src)
    if LogMegaphoneUsage then LogMegaphoneUsage(src, 'Megaphone deaktiviert') end
end)
