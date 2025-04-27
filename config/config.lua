-- MLeeM's Car Megaphone - Konfigurationsdatei
Config = {}

-- Liste der erlaubten Jobs
Config.AllowedJobs = {
    'police', 'fib', 'immigration', 'sheriff', 'ranger'
}

-- Fahrzeugklassen (z.B. 18 = Emergency)
Config.AllowedVehicleClasses = {18}
-- Fahrzeugmodelle (optional, falls du bestimmte Modelle erlauben willst)
Config.AllowedVehicleModels = {
    'police', 'police2', 'police3', 'police4', 'fbi', 'fbi2', 'sheriff', 'sheriff2'
}

-- Sprachreichweite (Meter)
Config.MegaphoneRange = 75.0

-- Taste zur Aktivierung (RegisterKeyMapping, Standard: nicht zugewiesen)
Config.ActivationKey = 'NUMPAD7' -- Beispiel: 'NUMPAD7', 'F10', 'G', etc.
-- Standardmäßig nicht zugewiesen, wenn leer gelassen   

-- Audio-Submix
Config.UseSubmix = true
Config.SubmixName = 'megaphone_1'
Config.SubmixEffects = {
    default = 1,
    freq_low = 300.0,
    freq_hi = 3000.0,
    rm_mod_freq = 100.0,
    rm_mix = 0.5
}

-- Cooldown (Millisekunden)
Config.Cooldown = 10000

-- Benachrichtigungen
Config.Notifications = {
    megaphone_on = 'Megaphon aktiviert.',
    megaphone_off = 'Megaphon deaktiviert.',
    not_allowed = 'Du darfst das Megaphon nicht benutzen.',
    cooldown = 'Megaphon ist auf Cooldown.',
}