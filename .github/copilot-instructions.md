<!--
Repository: mm_megaphone
Purpose: Guidance for AI coding agents (Copilot/GitHub agents) to work productively in this repo.
-->

# Copilot / AI Agent Instructions — mm_megaphone

- Purpose: Make safe, discoverable edits to this FiveM resource (client/server).

- Big picture (one-liner): client controls input and voice overrides; server enforces permissions and logs usage; a bridge detects frameworks.

- Core files to read first:
  - `fxmanifest.lua` — resource manifest, dependency `pma-voice`.
  - `config/config.lua` — shared `Config` table (defaults, locales, presets).
  - `bridge/framework.lua` — ESX/QB/ox detection and helper APIs.
  - `client/main.lua`, `client/submix.lua` — input, `pma-voice` overrides, Mumble submix handling.
  - `server/main.lua`, `logs/logs.lua` — server-side validation and persistent logging.

- Quick cookbook (copy/paste safe patterns):
  - Permission checks (client): call `CanUseCarMegaphone()` from bridge.
  - Voice override (client): `exports['pma-voice']:overrideProximityRange(range, true)` and on stop `exports['pma-voice']:clearProximityOverride()`.
  - Apply audio effect: create single submix `CreateAudioSubmix(Config.SubmixName)` and `MumbleSetSubmixForServerId(PlayerId(), submix)`; remove with `MumbleSetSubmixForServerId(PlayerId(), -1)`.
  - Server safety: duplicate any permission check on server before emitting events (see `server/main.lua` for ESX/QB examples).

- Conventions & guarantees:
  - `Config` is shared and authoritative — update `config/config.lua` when changing defaults.
  - Notifications use keys in `Config.Notifications` and translations in `Config.Locales`.
  - Event and export names use `mm_megaphone:*` or exported fn names (e.g., `ActivateMegaphone`).

- Workflows worth knowing:
  - Local test: copy resource to FiveM server `resources/`, then in server console run `refresh` and `ensure mm_megaphone`.
  - Release: `.github/workflows/release.yml` packages a tarball and creates a GitHub release; it optionally posts to Discord if `secrets.DISCORD_WEBHOOK_URL` exists.

- Safety notes (must follow):
  - Never rely only on client checks for permissions. Add server-side validation for any action that changes game state or grants abilities.
  - Clean up audio submixes — avoid creating per-player submixes without removal.

- Unknowns / ask-before-changing:
  - CI runner `runs-on: lunexor` and any release/deployment secrets (Discord webhook). Confirm before modifying release workflow or runner settings.

If you want, I can add a short code example showing how to add a new export with server validation and locale entry — say "export-example" and I'll append it.
<!--
Repository: mm_megaphone
Purpose: Guidance for AI coding agents (Copilot/GitHub agents) to work productively in this repo.
Do not include speculative or non-discoverable practices. Reference only files and patterns present in the tree.
-->

# Copilot / AI Agent Instructions — mm_megaphone

Summary
- This repository is a FiveM resource that implements an in-vehicle megaphone system for police roles. Key runtime pieces: `fxmanifest.lua`, `config/config.lua`, `bridge/framework.lua`, client files in `client/`, server files in `server/`, and the logging helper in `logs/`.

Quick architecture
- Resource manifest: `fxmanifest.lua` declares dependencies and scripts. `pma-voice` is a required dependency (audio/voice integration).
- Shared config: `config/config.lua` is loaded as a `shared_scripts` entry and provides runtime-config, locales, and presets used by both client and server.
- Client responsibilities (`client/main.lua`, `client/submix.lua`): keybinds and behavior for activating the megaphone, calling `exports['pma-voice']` to override proximity, applying/removing audio submix via Mumble API, and optional vehicle light effects.
- Server responsibilities (`server/main.lua`, `logs/logs.lua`): server-side validation (double-check job/permissions), forward events to client (TriggerClientEvent) and persist usage logs to `logs/megaphone.log` using SaveResourceFile/LoadResourceFile.
- Bridge (`bridge/framework.lua`): detects ESX / QBCore / ox_core or standalone mode, exposes helper functions used by client/server (e.g., `GetPlayerJob()`, `CanUseCarMegaphone()`, `ShowNotification()`). Use these exported helpers rather than re-implementing framework checks.

Important files & examples
- `fxmanifest.lua`: dependency `pma-voice`, shared scripts, client and server script lists.
- `config/config.lua`: central place for allowed jobs, vehicles, range presets, `Config.Notifications` keys, toggle vs hold behavior, and `Config.UseSubmix`/`Config.SubmixEffects` values.
- `bridge/framework.lua`: shows how to detect frameworks and call ESX/QB/ox APIs. Example functions to reuse: `GetPlayerJob()`, `RegisterFrameworkEvents()`, `CanUseCarMegaphone()`, `ShowNotification(msgKey)`.
- `client/main.lua`: core runtime flow. Example: uses `exports['pma-voice']:overrideProximityRange(currentRange, true)` to temporarily increase voice range and `exports['pma-voice']:clearProximityOverride()` to restore.
- `client/submix.lua`: audio effects. Example: `CreateAudioSubmix(Config.SubmixName)` and `MumbleSetSubmixForServerId(PlayerId(), megaphoneSubmix)`.
- `server/main.lua`: server validation pattern. Example: before applying submix, checks ESX and QBCore job data server-side and only forwards the event when allowed.

Conventions and idioms
- Shared `Config` object: read and write at runtime (client updates `Config.MegaphoneRange` for override). Treat `Config` as canonical source for settings.
- Job/vehicle checks: prefer `bridge` helpers (e.g., `CanUseCarMegaphone()`) and match server-side validations in `server/main.lua` for security.
- Notifications: message keys live in `Config.Notifications` and `Config.Locales`; always call `ShowNotification(Config.Notifications.<key>)` where practical so messages are localized uniformly.
- Exports & event names: follow the `mm_megaphone:*` pattern for events and use exported function names like `ActivateMegaphone`, `DeactivateMegaphone`, `ApplyMegaphoneSubmix`, `RemoveMegaphoneSubmix`, `LogMegaphoneUsage` if calling across contexts.

Developer workflows (discoverable)
- Local testing: run a FiveM server and place `mm_megaphone` inside your `resources` folder. Add `ensure pma-voice` and `ensure mm_megaphone` to server config (also referenced in README). Use `refresh` + `ensure mm_megaphone` in server console after changes.
- Release: `.github/workflows/release.yml` builds a tarball and creates a GitHub release, then posts a Discord notification if `secrets.DISCORD_WEBHOOK_URL` is set. The release workflow expects a tag name or a `workflow_dispatch` `version` input.
- CI / lint: repo contains `.github/workflows/lua-lint.yml` (lint workflow). Editor configs added to the repo (`.luarc.json`, `.vscode/settings.json`, `.markdownlint.json`) are intended to reduce local editor noise and mirror project conventions.

Patterns to avoid or be careful with
- Do not rely solely on client-side checks for permissions — server-side validation is present and required (see `server/main.lua`). If adding new permission-requiring features, mirror a server-side validation path.
- When changing audio/submix behavior, follow the `client/submix.lua` pattern (use Mumble APIs and `MumbleSetSubmixForServerId`). Avoid creating multiple submixes per player without cleaning them up.

Editing & contribution guidance for AI agents
- When editing behavior that affects gameplay (range, cooldown, visual effects), update `config/config.lua` defaults and `Config.Locales` entries where necessary.
- If adding public API (exports or events), choose names under `mm_megaphone:*` and ensure there is server-side validation when the action has security implications.
- Keep changes backwards compatible: `fxmanifest.lua` lists required files and dependencies; avoid removing `dependency 'pma-voice'` unless migrating to a different voice system and update README and release workflow accordingly.

What I could not discover automatically
- Exact local dev server commands or environment the original author uses (beyond `refresh`/`ensure`) and any credentials/secrets for Discord releases. CI runner `runs-on: lunexor` is present in `release.yml` but not further documented here — assume standard GitHub Actions runners unless you manage a self-hosted runner named `lunexor`.

If anything here looks incorrect or missing, reply with the specifics you'd like included (examples, preferred code style rules, or additional internal commands) and I'll iterate.
