Config = {}

-- Erlaubte Jobs
Config.AllowedJobs = { "police", "fib", "immigration" }

-- Fahrzeug-Einschränkung: Nur Emergency-Klasse (18) ODER bestimmte Modelle
Config.AllowedVehicleClasses = { 18 }
Config.AllowedVehicleModels = { "police", "police2", "fbi", "sheriff" }

-- Sprachreichweite des Megaphons
Config.MegaphoneRange = 50.0

-- Standard-Keybind (kann im Spiel geändert werden)
Config.ActivationKey = 'NUMPAD7' -- z.B. 'G' oder leer lassen für freie Belegung

-- Submix-Effekt aktivieren
Config.UseSubmix = true
Config.SubmixName = 'megaphone_1'

-- Sprache wählen
Config.Locale = 'en' -- z.B. 'en' oder 'de'

-- Übersetzungen
Config.Locales = {
    en = {
        MegaphoneActivated = "Megaphone activated!",
        MegaphoneDeactivated = "Megaphone deactivated.",
        NotAllowedVehicle = "You must be in a police vehicle.",
        NotAllowedJob = "You do not have permission to use the megaphone.",
        CooldownActive = "Please wait before using the megaphone again."
    },
    de = {
        MegaphoneActivated = "Megafon aktiviert!",
        MegaphoneDeactivated = "Megafon deaktiviert.",
        NotAllowedVehicle = "Du musst in einem Polizeifahrzeug sitzen.",
        NotAllowedJob = "Du hast keine Berechtigung, das Megafon zu benutzen.",
        CooldownActive = "Bitte warte, bevor du das Megafon erneut benutzt."
    },
    fr = {
        MegaphoneActivated = "Mégaphone activé !",
        MegaphoneDeactivated = "Mégaphone désactivé.",
        NotAllowedVehicle = "Vous devez être dans un véhicule de police.",
        NotAllowedJob = "Vous n'avez pas la permission d'utiliser le mégaphone.",
        CooldownActive = "Veuillez patienter avant d'utiliser à nouveau le mégaphone."
    },
    es = {
        MegaphoneActivated = "¡Megáfono activado!",
        MegaphoneDeactivated = "Megáfono desactivado.",
        NotAllowedVehicle = "Debes estar en un vehículo policial.",
        NotAllowedJob = "No tienes permiso para usar el megáfono.",
        CooldownActive = "Por favor espera antes de usar el megáfono de nuevo."
    },
    it = {
        MegaphoneActivated = "Megafono attivato!",
        MegaphoneDeactivated = "Megafono disattivato.",
        NotAllowedVehicle = "Devi essere in un veicolo della polizia.",
        NotAllowedJob = "Non hai il permesso di usare il megafono.",
        CooldownActive = "Attendi prima di usare di nuovo il megafono."
    },
    pt = {
        MegaphoneActivated = "Megafone ativado!",
        MegaphoneDeactivated = "Megafone desativado.",
        NotAllowedVehicle = "Você deve estar em um veículo policial.",
        NotAllowedJob = "Você não tem permissão para usar o megafone.",
        CooldownActive = "Por favor, aguarde antes de usar o megafone novamente."
    },
    ru = {
        MegaphoneActivated = "Мегафон активирован!",
        MegaphoneDeactivated = "Мегафон деактивирован.",
        NotAllowedVehicle = "Вы должны находиться в полицейском автомобиле.",
        NotAllowedJob = "У вас нет разрешения использовать мегафон.",
        CooldownActive = "Пожалуйста, подождите, прежде чем снова использовать мегафон."
    },
    tr = {
        MegaphoneActivated = "Megafon etkinleştirildi!",
        MegaphoneDeactivated = "Megafon devre dışı bırakıldı.",
        NotAllowedVehicle = "Bir polis aracında olmalısınız.",
        NotAllowedJob = "Megafonu kullanma izniniz yok.",
        CooldownActive = "Lütfen megafonu tekrar kullanmadan önce bekleyin."
    },
    pl = {
        MegaphoneActivated = "Megafon aktywowany!",
        MegaphoneDeactivated = "Megafon dezaktywowany.",
        NotAllowedVehicle = "Musisz być w pojeździe policyjnym.",
        NotAllowedJob = "Nie masz uprawnień do używania megafonu.",
        CooldownActive = "Poczekaj przed ponownym użyciem megafonu."
    }
}

-- Framework-Integration explizit aktivieren/deaktivieren
Config.EnableFrameworkIntegration = true