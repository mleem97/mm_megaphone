--[[
    MLeeM's Car Megaphone - Audio Submix
    Diese Datei enthält die Logik für den Audio-Submix-Effekt.
]]--

local megaphoneSubmix

function ApplyMegaphoneSubmix()
    if not Config.UseSubmix then return end
    if not megaphoneSubmix then
        megaphoneSubmix = CreateAudioSubmix(Config.SubmixName)
        SetAudioSubmixEffectRadioFx(megaphoneSubmix, 0)
        SetAudioSubmixEffectParamInt(megaphoneSubmix, 0, 'default', Config.SubmixEffects.default)
        SetAudioSubmixEffectParamFloat(megaphoneSubmix, 0, 'freq_low', Config.SubmixEffects.freq_low)
        SetAudioSubmixEffectParamFloat(megaphoneSubmix, 0, 'freq_hi', Config.SubmixEffects.freq_hi)
        SetAudioSubmixEffectParamFloat(megaphoneSubmix, 0, 'rm_mod_freq', Config.SubmixEffects.rm_mod_freq)
        SetAudioSubmixEffectParamFloat(megaphoneSubmix, 0, 'rm_mix', Config.SubmixEffects.rm_mix)
        AddAudioSubmixOutput(megaphoneSubmix, 0)
    end
    MumbleSetAudioInputIntent("speech")
    MumbleSetSubmixForServerId(PlayerId(), megaphoneSubmix)
end

function RemoveMegaphoneSubmix()
    if not Config.UseSubmix then return end
    if megaphoneSubmix then
        MumbleSetSubmixForServerId(PlayerId(), -1)
    end
end

RegisterNetEvent("mm_megaphone:applySubmix", ApplyMegaphoneSubmix)
RegisterNetEvent("mm_megaphone:removeSubmix", RemoveMegaphoneSubmix)