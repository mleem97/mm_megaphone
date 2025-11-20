# MLeeM's Car Megaphone 🚔📢
[![Lua Lint](https://github.com/mleem97/mm_megaphone/actions/workflows/lua-lint.yml/badge.svg)](https://github.com/mleem97/mm_megaphone/actions/workflows/lua-lint.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![FiveM](https://img.shields.io/badge/FiveM-Compatible-blue.svg)](https://fivem.net/)
[![Version](https://img.shields.io/badge/version-1.3.1b-green.svg)](https://github.com/mleem97/mm_megaphone/releases)

A powerful and optimized FiveM addon that enables police officers to use an in-vehicle megaphone system. Perfect for traffic stops, operations, and large-scale events with realistic audio effects and extensive customization options.

## ✨ Features

- 🎤 **Enhanced Voice Range:** Extends voice chat up to 75 meters while active
- 🔧 **Multi-Framework Support:** ESX, QBCore, ox_core, and standalone mode with automatic detection
- 🚓 **Smart Vehicle Detection:** Job and vehicle-based permissions (configurable)
- 🔊 **Realistic Audio Effects:** Optional audio submix for authentic megaphone sound
- ⌨️ **Flexible Controls:** Customizable keybind with hold-to-talk functionality
- ⏱️ **Anti-Spam Protection:** Built-in cooldown system
- 💡 **Visual Feedback:** Optional vehicle light effects while active
- 📝 **Server Logging:** Track all megaphone usage with detailed logs
- 🌍 **Multi-Language:** Support for 9+ languages (EN, DE, FR, ES, IT, PT, RU, TR, PL)
- 🎯 **Optimized Performance:** Minimal resource usage with dynamic thread management

## 📋 Requirements

| Requirement | Version | Notes |
|------------|---------|-------|
| **FiveM Server** | Build 2545+ | Recommended: Latest stable |
| **pma-voice** | v6.6.2+ | [Download](https://github.com/AvarianKnight/pma-voice) |
| **Framework** | Optional | ESX Legacy, QBCore, ox_core, or standalone |
| **Game Build** | 2699+ | For best compatibility |

## 📦 Installation

### Step 1: Download
```
# Clone repository
git clone https://github.com/mleem97/mm_megaphone.git

# Or download latest release
# https://github.com/mleem97/mm_megaphone/releases/latest
```

### Step 2: Install
1. Copy the `mm_megaphone` folder to your server's `resources` directory
2. Add to your `server.cfg`:
   ```
   ensure pma-voice
   ensure mm_megaphone
   ```

### Step 3: Configure
1. Navigate to `config/config.lua`
2. Adjust settings to match your server setup
3. Restart your server or run `refresh` and `ensure mm_megaphone`

## ⚙️ Configuration

### Basic Settings
```lua
-- Allowed Jobs
Config.AllowedJobs = { "police", "fib", "sheriff", "state", "immigration" }

-- Vehicle Restrictions
Config.AllowedVehicleClasses = { 18 }  -- 18 = Emergency Vehicles
Config.AllowedVehicleModels = { "police", "police2", "police3", "fbi", "sheriff" }

-- Megaphone Settings
Config.MegaphoneRange = 75.0           -- Voice range in meters
Config.Cooldown = 3000                 -- Cooldown in milliseconds
Config.UseVisualEffects = true         -- Flash vehicle lights
Config.UseSubmix = true                -- Enable megaphone audio effect
```

### Keybind Configuration
```lua
Config.ActivationKey = 'NUMPAD7'  -- Default key (customizable in-game)
```

**Available in FiveM Key Mapping:**
- Open: `ESC > Settings > Key Bindings > FiveM`
- Search for: "Car Megaphone"
- Assign your preferred key

### Language Support
```lua
Config.Locale = 'en'  -- Available: en, de, fr, es, it, pt, ru, tr, pl
```

## 🎮 Usage

### For Players
1. **Enter a police vehicle** as an authorized officer
2. **Press and hold** your configured megaphone key (default: `NUMPAD7`)
3. **Speak normally** – your voice will be amplified to the configured range
4. **Release the key** to return to normal voice range

### For Server Owners
- Monitor usage via server logs (`logs/logs.lua`)
- Adjust range, cooldown, and effects in `config/config.lua`
- Customize allowed jobs and vehicles per your server needs

## 🏗️ Project Structure

```
mm_megaphone/
├── 📁 config/
│   └── config.lua          # Main configuration file
├── 📁 bridge/
│   └── framework.lua       # Framework detection & integration
├── 📁 client/
│   ├── main.lua           # Core client logic
│   └── submix.lua         # Audio effects system
├── 📁 server/
│   └── main.lua           # Server-side events
├── 📁 logs/
│   └── logs.lua           # Logging functionality
└── fxmanifest.lua         # Resource manifest
```

## 🔧 Advanced Configuration

### Custom Audio Effects
```lua
Config.SubmixEffects = {
    defaultParam = 0,
    default = 0,
    freq_lowParam = 1,
    freq_low = 300.0,      -- Low frequency cutoff
    freq_hiParam = 2,
    freq_hi = 5000.0,      -- High frequency cutoff
    rm_mod_freqParam = 3,
    rm_mod_freq = 300.0,   -- Ring modulator frequency
    rm_mixParam = 4,
    rm_mix = 0.2           -- Effect mix level
}
```

### Framework Integration
```lua
Config.EnableFrameworkIntegration = true  -- Disable for standalone mode
```

## 🐛 Troubleshooting

### Common Issues

**Problem:** Megaphone doesn't activate
- ✅ Ensure you're in an allowed vehicle
- ✅ Check that your job is in `Config.AllowedJobs`
- ✅ Verify pma-voice is running: `ensure pma-voice`
- ✅ Check console for errors: `F8` in-game

**Problem:** No audio effect
- ✅ Set `Config.UseSubmix = true` in config
- ✅ Restart the resource after config changes
- ✅ Verify pma-voice version compatibility

**Problem:** Key doesn't work
- ✅ Check FiveM Key Bindings settings
- ✅ Try rebinding the key in-game
- ✅ Ensure no other resource uses the same key

**Problem:** Works for everyone (no job restriction)
- ✅ Verify framework is detected: Check server console
- ✅ Ensure `Config.EnableFrameworkIntegration = true`
- ✅ Confirm your framework is properly installed

### Debug Mode
Enable verbose logging by adding this to `server/main.lua`:
```lua
Config.Debug = true  -- Add to config.lua
```

## 🤝 Contributing

Contributions are welcome! Please:
1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📝 Changelog

### Version 1.3.0 (2025-11)
- ✨ Enhanced pma-voice v7.x compatibility
- 🔧 Performance optimizations
- 🌍 Extended language support
- 📝 Improved documentation

### Version 1.2.0 (2025-04)
- ✨ Added visual effects
- 🔧 Framework detection improvements
- 📝 Enhanced logging system

[View Full Changelog](https://github.com/mleem97/mm_megaphone/releases)

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 💬 Support & Community

- 🐛 **Bug Reports:** [GitHub Issues](https://github.com/mleem97/mm_megaphone/issues)
- 💡 **Feature Requests:** [GitHub Discussions](https://github.com/mleem97/mm_megaphone/discussions)
- 📧 **Contact:** Open an issue for support

> **Note:** Without an issue submission, bugs cannot be tracked or fixed. Please provide detailed reproduction steps!

## ⭐ Show Your Support

If you find this resource helpful, please consider:
- ⭐ Starring this repository
- 🔄 Sharing it with your community
- 🐛 Reporting bugs to help improve it

## 👨‍💻 About

**Author:** MLeeM  
**Created:** 2025 (Freelance FiveM Development)  
**GitHub:** [@mleem97](https://github.com/mleem97)

---

<div align="center">

**Made with ❤️ for the FiveM Community**

[Report Bug](https://github.com/mleem97/mm_megaphone/issues) · [Request Feature](https://github.com/mleem97/mm_megaphone/issues) · [Documentation](https://github.com/mleem97/mm_megaphone/wiki)

</div>
