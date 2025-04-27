-- Hauptkonfigurationsdatei für das Megaphon-Script

Config = {}

-- Liste der erlaubten Jobs
Config.AllowedJobs = {"police", "fib", "immigration"}

-- Submix-Optionen
Config.UseSubmix = true

-- Lautstärkeregelung
Config.VolumeLevels = {
    low = 30.0,
    normal = 50.0,
    high = 70.0
}
Config.DefaultVolume = "normal"

-- Cooldown-Einstellungen
Config.CooldownTime = 10000 -- in Millisekunden

-- Mehrsprachigkeit
Config.Messages = {
    CooldownActive = "Das Megaphon ist derzeit auf Cooldown.",
    VolumeSet = "Megaphon-Lautstärke eingestellt auf: ",
    InvalidVolume = "Ungültige Lautstärke. Verfügbare Optionen: low, normal, high.",
    NotAllowedVehicle = "Dieses Fahrzeug unterstützt kein Megaphon.",
}