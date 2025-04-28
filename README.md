# MLeeM's Car Megaphone

## Description
This plugin was created as part of my freelancing work for a FiveM server.

This addon allows players with a police job to use a megaphone while in a vehicle. This significantly increases the voice chat range, so instructions and announcements can be heard outside the vehicle and over greater distances – ideal for traffic stops, operations, or large-scale events.

The script is compatible with the most common FiveM frameworks (ESX, QBCore, ox_core) as well as standalone operation. Framework detection is automatic.

## Features

- **Megaphone Function:** Increases voice range up to 50 meters while the megaphone key is held down.
- **Framework Compatibility:** Supports ESX, QBCore, ox_core, and standalone.
- **Job and Vehicle Check:** Only players with an allowed police job (e.g., "police", "fib", "immigration") and in a police vehicle can use the megaphone.
- **Optional Audio Submix:** (Configurable) For a more realistic megaphone sound.
- **Easy Operation:** Activation via freely assignable key.
- **Central Configuration:** All settings can be adjusted in the `config/config.lua` file.
- **Cooldown System:** Protection against spam through configurable cooldown.
- **Visual Effects:** Vehicle lights flash when the megaphone is active (optional).
- **Server-side Logging:** Megaphone usage is logged with player info.

## Installation

1. **Upload files:** Copy the addon to your `resources` folder.
2. **Start in server.cfg:**
   ```conf
   ensure mm_megaphone
   ```
3. **Dependencies:**
   - [pma-voice](https://github.com/AvarianKnight/pma-voice) (voice plugin)
   - One of the supported frameworks (ESX, QBCore, ox_core) or standalone

## Configuration

All settings can be found in the `config/config.lua` file:
- **Config.AllowedJobs:** List of allowed jobs (e.g., 'police', 'fib', 'immigration')
- **Config.AllowedVehicleClasses:** Allowed vehicle classes (e.g., 18 for Emergency)
- **Config.AllowedVehicleModels:** Allowed vehicle models (spawn names)
- **Config.MegaphoneRange:** Voice range in meters
- **Config.ActivationKey:** Empty by default, can be assigned in-game
- **Config.UseSubmix:** true/false for megaphone sound effect
- **Config.SubmixName/SubmixEffects:** Name and parameters of the submix
- **Config.Cooldown:** Cooldown time in milliseconds
- **Config.Notifications:** Customizable notifications

## Usage

1. Get into a police vehicle as a police officer.
2. Press and hold the configured key (can be assigned in the menu, e.g., F5).
3. Your voice will now be transmitted within a 50-meter radius (and optionally with a megaphone effect).
4. Release the key to restore the normal voice range.

## Structure

- `config/config.lua` – central configuration
- `bridge/framework.lua` – framework detection & wrappers
- `client/main.lua` – client main logic (keys, checks, voice)
- `client/submix.lua` – submix logic (audio effect)
- `server/main.lua` – server events for submix & logging
- `logs/logs.lua` – logic for server-side logging
- `fxmanifest.lua` – resource definition

## Support

If you have questions or issues, you can open an issue on GitHub or contact the developer.
