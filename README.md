# MLeeM's Car Megaphone

## Beschreibung

Dieses Addon ermöglicht es Spielern mit einem Polizeijob, im Fahrzeug ein Megafon zu verwenden. Dadurch wird die Sprachreichweite im Voice-Chat deutlich erhöht, sodass Anweisungen und Durchsagen auch außerhalb des Fahrzeugs und über größere Entfernungen hinweg verständlich sind – ideal für Verkehrskontrollen, Einsätze oder Großlagen.

Das Script ist kompatibel mit den gängigen FiveM-Frameworks (ESX, QBCore, ox_core) sowie im Standalone-Betrieb. Die Framework-Erkennung erfolgt automatisch.

## Features

- **Megafon-Funktion:** Erhöht die Sprachreichweite auf bis zu 50 Meter, solange die Megafon-Taste gedrückt wird.
- **Framework-Kompatibilität:** Unterstützt ESX, QBCore, ox_core und Standalone.
- **Job- und Fahrzeugprüfung:** Nur Spieler mit einem erlaubten Polizeijob (z. B. "police", "fib", "immigration") und in einem Polizeifahrzeug können das Megafon nutzen.
- **Optionaler Audio-Submix:** (Konfigurierbar) Für realistischeren Megafon-Sound.
- **Einfache Bedienung:** Aktivierung über frei belegbare Taste.
- **Zentrale Konfiguration:** Alle Einstellungen können in der Datei `config/config.lua` angepasst werden.
- **Cooldown-System:** Schutz vor Spam durch einstellbare Abklingzeit.
- **Visuelle Effekte:** Fahrzeuglichter blinken beim aktiven Megafon (optional).
- **Serverseitiges Logging:** Nutzung des Megafons wird mit Spielerinfos protokolliert.

## Installation

1. **Dateien hochladen:** Das Addon in deinen `resources`-Ordner kopieren.
2. **In der server.cfg starten:**
   ```
   ensure mm_megaphone
   ```
3. **Abhängigkeiten:**
   - [pma-voice](https://github.com/AvarianKnight/pma-voice) (Voice-Plugin)
   - Eines der unterstützten Frameworks (ESX, QBCore, ox_core) oder Standalone

## Konfiguration

Alle Einstellungen findest du in der Datei `config/config.lua`:
- **Config.AllowedJobs:** Liste der erlaubten Jobs (z. B. 'police', 'fib', 'immigration')
- **Config.AllowedVehicleClasses:** Erlaubte Fahrzeugklassen (z. B. 18 für Emergency)
- **Config.AllowedVehicleModels:** Erlaubte Fahrzeugmodelle (Spawnnamen)
- **Config.MegaphoneRange:** Sprachreichweite in Metern
- **Config.ActivationKey:** Standardmäßig leer, kann im Spiel belegt werden
- **Config.UseSubmix:** true/false für Megafon-Soundeffekt
- **Config.SubmixName/SubmixEffects:** Name und Parameter des Submixes
- **Config.Cooldown:** Cooldown-Zeit in Millisekunden
- **Config.Notifications:** Anpassbare Benachrichtigungen

## Nutzung

1. Steige als Polizist in ein Polizeifahrzeug.
2. Drücke und halte die konfigurierte Taste (im Menü belegbar, z. B. F5).
3. Deine Stimme wird nun im Umkreis von 50 Metern übertragen (und optional mit Megafon-Effekt versehen).
4. Lasse die Taste los, um die normale Sprachreichweite wiederherzustellen.

## Struktur

- `config/config.lua` – zentrale Konfiguration
- `bridge/framework.lua` – Framework-Erkennung & Wrapper
- `client/main.lua` – Client-Hauptlogik (Tasten, Checks, Voice)
- `client/submix.lua` – Submix-Logik (Audioeffekt)
- `server/main.lua` – Server-Events für Submix & Logging
- `logs/logs.lua` – Logik für serverseitiges Logging
- `fxmanifest.lua` – Resource-Definition

## Support

Bei Fragen oder Problemen kannst du ein Issue auf GitHub eröffnen oder dich an den Entwickler wenden.
