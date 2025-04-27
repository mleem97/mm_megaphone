--[[
    MLeeM's Car Megaphone - Konfigurationsdatei
    Hier können alle Einstellungen des Addons angepasst werden.
]]--

Config = {}

-- Liste der erlaubten Jobs
Config.AllowedJobs = {
    "police",    -- Polizei
    "fib",       -- FBI
    "immigration", -- Einwanderungsbehörde
    "sheriff",   -- Sheriff
    "ranger"     -- Park Ranger
}

-- Fahrzeugeinstellungen
Config.AllowedVehicleClasses = {18} -- 18 = Einsatzfahrzeuge
Config.AllowedVehicleModels = { -- Wird nur geprüft, wenn AllowedVehicleClasses leer ist
    "police",
    "police2",
    "police3",
    "police4",
    "fbi",
    "fbi2",
    "sheriff",
    "sheriff2"
}

-- Megaphon-Einstellungen
Config.MegaphoneRange = 50.0 -- Reichweite in Metern
Config.CooldownTime = 10000 -- Cooldown in Millisekunden (10 Sekunden)

-- Audio-Submix Einstellungen
Config.UseSubmix = true
Config.SubmixName = "Megaphone"
Config.SubmixEffects = {
    default = 1,
    freq_low = 300.0,
    freq_hi = 3000.0,
    rm_mod_freq = 100.0,
    rm_mix = 0.5
}

-- Lautstärkeregelung
Config.VolumeLevels = {
    low = 30.0,
    normal = 50.0,
    high = 70.0
}
Config.DefaultVolume = "normal"

-- Visuelle Effekte
Config.UseVisualEffects = true

-- Mehrsprachigkeit
Config.Messages = {
    CooldownActive = "Das Megaphon ist derzeit auf Cooldown.",
    VolumeSet = "Megaphon-Lautstärke eingestellt auf: ",
    InvalidVolume = "Ungültige Lautstärke. Verfügbare Optionen: low, normal, high.",
    NotAllowedVehicle = "Dieses Fahrzeug unterstützt kein Megaphon.",
    NotAllowedJob = "Du hast keine Berechtigung, das Megaphon zu verwenden.",
    MegaphoneActivated = "Megaphon aktiviert.",
    MegaphoneDeactivated = "Megaphon deaktiviert."
}