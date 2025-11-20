-- .luacheckrc - Luacheck configuration for mm_megaphone FiveM addon
std = "lua53"

-- Global variables that are set/modified by this addon
return {
    std = "lua54",
    max_line_length = 140,

    -- Global variables defined/used by this resource
    globals = {
        "Config",
        "LogMegaphoneUsage",
    },

    -- Read-only globals provided by FiveM / dependencies
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

        -- Entity / Vehicle / Ped functions
        "GetEntityCoords",
        "GetEntityHeading",
        "GetEntityModel",
        "NetworkGetNetworkIdFromEntity",
        "IsPedInAnyVehicle",
        "GetPedInVehicleSeat",
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

        -- Exports / frameworks
        "exports",
        "ESX",
        "QBCore",
        "lib",

        -- MySQL
        "MySQL",

        -- fxmanifest keys (treated as globals in manifest file parsing)
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

    -- Files / dirs to exclude from linting
    exclude_files = {
        "fxmanifest.lua",
        ".github/**",
    },

    -- Common ignores
    ignore = {
        "211/_.*", -- Unused variable starting with underscore
        "212",     -- Unused argument
        "213",     -- Unused loop variable
        "311",     -- Value assigned to variable is unused
    },

    files = {
        ["config/*.lua"] = {
            globals = { "Config" },
            ignore = { "111", "112", "113" },
            max_line_length = false,
        },

        ["fxmanifest.lua"] = {
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
        },

        ["bridge/framework.lua"] = {
            globals = {
                "Config",
            },
        },

        ["client/submix.lua"] = {
            globals = { "ApplyMegaphoneSubmix", "RemoveMegaphoneSubmix" },
            max_line_length = 140,
        },

        ["logs/logs.lua"] = {
            globals = { "LogMegaphoneUsage" },
        },
    },
}
        "dependency",
