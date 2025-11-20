-- .luacheckrc - Luacheck configuration for mm_megaphone FiveM addon
std = "lua53"

-- Global variables that are set/modified by this addon
globals = {
    "Config",
    "GetPlayerJob",
    "RegisterFrameworkEvents",
    "IsPlayerInAllowedVehicle",
    "IsPlayerInAllowedJob",
    "CanUseCarMegaphone",
    "ShowNotification",
    "ActivateMegaphone",
    "DeactivateMegaphone",
    "ActivateVisualEffects",
    "DeactivateVisualEffects",
    "ApplyMegaphoneSubmix",
    "RemoveMegaphoneSubmix",
    "LogMegaphoneUsage",
}

-- Read-only globals from FiveM/Citizen and dependencies
read_globals = {
    -- Citizen/FiveM core
    "Citizen",
    "CreateThread",
    "Wait",
    "SetTimeout",
    
    -- Resource management
    "GetResourceState",
    "GetCurrentResourceName",
    "LoadResourceFile",
    "SaveResourceFile",
    "IsDuplicityVersion",
    
    -- Events
    "RegisterCommand",
    "RegisterNetEvent",
    "AddEventHandler",
    "RemoveEventHandler",
    "TriggerEvent",
    "TriggerServerEvent",
    "TriggerClientEvent",
    
    -- Key mapping
    "RegisterKeyMapping",
    
    -- Player functions
    "PlayerPedId",
    "GetPlayerPed",
    "PlayerId",
    "GetPlayerName",
    "GetPlayerIdentifiers",
    "source",
    
    -- Entity functions
    "GetEntityCoords",
    "GetEntityHeading",
    "GetEntityModel",
    "NetworkGetNetworkIdFromEntity",
    
    -- Ped functions
    "IsPedInAnyVehicle",
    "GetPedInVehicleSeat",
    
    -- Vehicle functions
    "GetVehiclePedIsIn",
    "GetVehicleClass",
    "GetDisplayNameFromVehicleModel",
    "SetVehicleLights",
    "SetVehicleIndicatorLights",
    
    -- Notifications
    "SetNotificationTextEntry",
    "AddTextComponentString",
    "DrawNotification",
    
    -- Audio/Sound
    "PlaySoundFrontend",
    "CreateAudioSubmix",
    "SetAudioSubmixEffectRadioFx",
    "SetAudioSubmixEffectParamInt",
    "SetAudioSubmixEffectParamFloat",
    "AddAudioSubmixOutput",
    
    -- Mumble (pma-voice)
    "MumbleSetAudioInputIntent",
    "MumbleSetSubmixForServerId",
    "MumbleSetAudioInputDistance",
    "MumbleSetTalkerProximity",
    
    -- Exports
    "exports",
    
    -- Framework globals
    "ESX",
    "QBCore",
    "lib",
    
    -- MySQL
    "MySQL",
}

-- Manifest-specific globals
read_globals["fx_version"] = true
read_globals["game"] = true
read_globals["lua54"] = true
read_globals["author"] = true
read_globals["description"] = true
read_globals["version"] = true
read_globals["dependency"] = true
read_globals["shared_scripts"] = true
read_globals["client_scripts"] = true
read_globals["server_scripts"] = true

-- Ignore specific warnings
ignore = {
    "211/_.*",      -- Unused variable starting with underscore
    "212",          -- Unused argument (common in event handlers)
    "213",          -- Unused loop variable
    "311",          -- Value assigned to variable is unused
    "542",          -- Empty if branch
    "631",          -- Line is too long (we'll handle this separately)
}

-- Exclude directories and files
exclude_files = {
    "**/node_modules/**",
    "**/.git/**",
    "**/build/**",
    "**/dist/**",
    "**/.vscode/**",
    "**/temp/**",
}

-- Line length settings
max_line_length = 120
max_code_line_length = 120
max_string_line_length = false
max_comment_line_length = false

-- File-specific overrides
files["config/*.lua"] = {
    globals = { "Config" },
    ignore = { "111", "112", "113" },  -- Allow setting global Config
    max_line_length = false,  -- Allow longer config lines
}

files["fxmanifest.lua"] = {
    globals = {
        "fx_version",
        "game",
        "lua54",
        "author",
        "description",
        "version",
        "dependency",
        "shared_scripts",
        "client_scripts",
        "server_scripts",
    },
    ignore = { "111", "112", "113" },
}

files["**/server/*.lua"] = {
    read_globals = {
        "source",  -- Available in server-side event handlers
        "MySQL",
    },
}

files["**/client/*.lua"] = {
    read_globals = {
        "SendNUIMessage",
        "SetNuiFocus",
        "RegisterNUICallback",
    },
}

files["bridge/framework.lua"] = {
    globals = {
        "Config",
        "GetPlayerJob",
        "RegisterFrameworkEvents",
        "IsPlayerInAllowedVehicle",
        "IsPlayerInAllowedJob",
        "CanUseCarMegaphone",
        "ShowNotification",
    },
}

files["client/main.lua"] = {
    globals = {
        "ActivateMegaphone",
        "DeactivateMegaphone",
        "ActivateVisualEffects",
        "DeactivateVisualEffects",
    },
    ignore = { "211" },  -- Unused variables (like lastPress)
}

files["client/submix.lua"] = {
    globals = {
        "ApplyMegaphoneSubmix",
        "RemoveMegaphoneSubmix",
    },
    max_line_length = 130,  -- Allow slightly longer lines for submix params
}

files["logs/logs.lua"] = {
    globals = {
        "LogMegaphoneUsage",
    },
}

-- Whitespace handling
allow_defined = false
allow_defined_top = false
module = false
unused = true
unused_args = true
unused_secondaries = false
self = false
std = "max"
