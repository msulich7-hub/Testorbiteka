# Testorbiteka

Repo robocze pod eksperymenty i notatki związane z platformą **[Orbiteus](https://github.com/orbiteus/orbiteus)** (silnik do budowy ERP/CRM i aplikacji biznesowych).

## Dokumenty

- **[Propozycje i analiza: co budować na Orbiteus](docs/ORBITUEUS-IDEAS.md)** — skrót platformy, mocne strony i lista pomysłów na projekty.
- **[MIMMS_pl ↔ Orbiteus — integracja](docs/MIMMS-ORBITEUS-INTEGRATION.md)** — jak podłączyć istniejącą aplikację (folder lokalny) do silnika Orbiteus; brak dostępu do `C:\...\22_MIMMS_pl` z chmury — lista plików do dosłania.

## Uruchomienie Orbiteusa u siebie (jednym skryptem)

1. Zainstaluj **Git** + **Docker Desktop** (Windows) albo **Docker + compose** (Linux).
2. Sklonuj to repo i uruchom:

**Windows (PowerShell):** `.\scripts\run-orbiteus.ps1`  
**Linux/macOS:** `./scripts/run-orbiteus.sh`

Skrypt tworzy folder **`orbiteus` obok** `Testorbiteka` i odpala `docker compose up --build`. Szczegóły: **[docs/RUN-ORBITEUS-LOCAL.md](docs/RUN-ORBITEUS-LOCAL.md)**.

Upstream Orbiteus klonujesz osobno z oficjalnego repozytorium; ten projekt może trzymać tylko Twoją dokumentację i ewentualne moduły/szkice pod własny fork.
