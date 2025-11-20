<!--
Repository: mm_megaphone
Purpose: Guidance for AI coding agents (Copilot/GitHub agents) to work productively in this repo.
Do not include speculative or non-discoverable practices. Reference only files and patterns present in the tree.
-->

# Copilot / AI Agent Instructions — mm_megaphone

## Overview

**Purpose**: FiveM resource implementing an in-vehicle megaphone system for police roles.

**Architecture at a glance**: Client controls input and voice overrides; server enforces permissions and logs usage; a bridge detects frameworks (ESX/QBCore/ox_core).

**Dependencies**: Requires `pma-voice` for voice/audio integration.

---

## Core Files to Understand First

Read these files in order to grasp the system:

1. **`fxmanifest.lua`** — Resource manifest, declares `pma-voice` dependency and all scripts.
2. **`config/config.lua`** — Shared `Config` table (defaults, locales, presets, notification keys). Loaded on both client and server.
3. **`bridge/framework.lua`** — Framework detection (ESX/QBCore/ox_core/standalone) and helper APIs for jobs, permissions, notifications.
4. **`client/main.lua`** — Client runtime: keybinds, activation/deactivation logic, `pma-voice` integration.
5. **`client/submix.lua`** — Audio effects via Mumble submix API.
6. **`server/main.lua`** — Server-side validation and event forwarding.
7. **`logs/logs.lua`** — Persistent logging to `logs/megaphone.log` using `SaveResourceFile`/`LoadResourceFile`.

---

## Quick Reference Patterns (Copy-Paste Safe)

### Permission Check (Client)
```
-- Use bridge helper
if CanUseCarMegaphone() then
    -- proceed
end
```

### Voice Range Override (Client)
```
-- Activate
exports['pma-voice']:overrideProximityRange(range, true)

-- Deactivate
exports['pma-voice']:clearProximityOverride()
```

### Audio Submix (Client)
```
-- Create and apply (do once)
local submix = CreateAudioSubmix(Config.SubmixName)
MumbleSetSubmixForServerId(PlayerId(), submix)

-- Remove
MumbleSetSubmixForServerId(PlayerId(), -1)
```

### Server-Side Validation Pattern
```
-- Always double-check permissions server-side
RegisterNetEvent('mm_megaphone:someAction', function()
    local src = source
    -- Validate job/vehicle here (see server/main.lua for ESX/QB examples)
    if not isAllowed then
        return -- reject silently or notify
    end
    -- proceed with TriggerClientEvent
end)
```

### Notifications
```
-- Use Config keys for localization
ShowNotification(Config.Notifications.no_permission)
```

---

## Conventions & Idioms

- **Config is authoritative**: `config/config.lua` is the single source of truth. Update defaults, locales, and presets there.
- **Bridge helpers**: Use functions from `bridge/framework.lua` (`GetPlayerJob()`, `CanUseCarMegaphone()`, `ShowNotification()`) rather than re-implementing framework checks.
- **Event naming**: Follow `mm_megaphone:*` pattern for events.
- **Export naming**: Use descriptive names like `ActivateMegaphone`, `DeactivateMegaphone`, `ApplyMegaphoneSubmix`, etc.
- **Localization**: All user-facing messages use keys from `Config.Notifications` and translations from `Config.Locales`.

---

## Developer Workflows

### Local Testing
1. Copy resource to FiveM server `resources/` folder.
2. Ensure `pma-voice` and `mm_megaphone` are in server config.
3. In server console:
   ```
   refresh
   ensure mm_megaphone
   ```

### Release Process
- `.github/workflows/release.yml` packages a tarball and creates a GitHub release.
- Posts to Discord if `secrets.DISCORD_WEBHOOK_URL` is configured.
- Triggered by tag creation or manual `workflow_dispatch` with version input.

### CI / Lint
- `.github/workflows/lua-lint.yml` runs Lua linting.
- Editor configs: `.luarc.json`, `.vscode/settings.json`, `.markdownlint.json` maintain consistency.

---

## Safety & Security Rules (Must Follow)

1. **Never rely solely on client checks**: Always validate permissions server-side before granting abilities or changing game state.
2. **Clean up audio submixes**: Avoid creating per-player submixes without removal. Use single submix pattern from `client/submix.lua`.
3. **Server-side validation required**: For any new permission-requiring feature, mirror the validation pattern in `server/main.lua`.
4. **Backwards compatibility**: Don't remove `dependency 'pma-voice'` or required files from `fxmanifest.lua` without updating README and release workflow.

---

## Adding New Features (Step-by-Step)

### Example: Adding a New Export with Server Validation

1. **Add config entries** (`config/config.lua`):
   ```
   Config.NewFeature = {
       enabled = true,
       range = 50.0
   }
   Config.Notifications.new_feature_active = "new_feature_active"
   Config.Locales["de"].new_feature_active = "Neues Feature aktiviert"
   Config.Locales["en"].new_feature_active = "New feature activated"
   ```

2. **Client export** (`client/main.lua`):
   ```
   exports('ActivateNewFeature', function()
       if not CanUseCarMegaphone() then
           ShowNotification(Config.Notifications.no_permission)
           return false
       end
       TriggerServerEvent('mm_megaphone:validateNewFeature')
       return true
   end)
   ```

3. **Server validation** (`server/main.lua`):
   ```
   RegisterNetEvent('mm_megaphone:validateNewFeature', function()
       local src = source
       -- ESX/QB job check (see existing patterns)
       if not serverSidePermissionCheck(src) then
           return
       end
       TriggerClientEvent('mm_megaphone:applyNewFeature', src)
   end)
   ```

4. **Client event handler** (`client/main.lua`):
   ```
   RegisterNetEvent('mm_megaphone:applyNewFeature', function()
       ShowNotification(Config.Notifications.new_feature_active)
       -- Apply feature logic
   end)
   ```

---

## Known Limitations / Ask Before Changing

- **CI Runner**: `.github/workflows/release.yml` uses `runs-on: lunexor` (potentially self-hosted). Confirm before modifying runner settings.
- **Discord Webhook**: Release workflow expects `secrets.DISCORD_WEBHOOK_URL`. Don't remove Discord notification logic without confirming.
- **Framework Detection**: `bridge/framework.lua` auto-detects ESX/QBCore/ox_core. Test thoroughly if modifying detection logic.

---

## File Structure Reference

```
mm_megaphone/
├── fxmanifest.lua           # Resource manifest
├── config/
│   └── config.lua           # Shared configuration (authoritative)
├── bridge/
│   └── framework.lua        # Framework detection & helpers
├── client/
│   ├── main.lua            # Core client logic
│   └── submix.lua          # Audio effects
├── server/
│   └── main.lua            # Server validation & events
├── logs/
│   └── logs.lua            # Persistent logging
├── .github/workflows/
│   ├── release.yml         # Release automation
│   └── lua-lint.yml        # Linting
└── README.md               # User documentation
```

---

**For questions or clarifications**: Reference specific files and line numbers. This document reflects discoverable patterns only—no speculation or assumptions about undocumented behavior.
