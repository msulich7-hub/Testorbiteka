# Orbiteus u siebie (Docker)

Orbiteus to osobne repozytorium. Skrypty w **Testorbitece** klonują je **obok** tego folderu jako `../orbiteus` i uruchamiają `docker compose up --build`.

## Struktura po pierwszym uruchomieniu

```text
.../aplikacje/
  Testorbiteka/          ← to repo (README, skrypty, docs)
  orbiteus/              ← klon z GitHuba (powstaje automatycznie)
```

## Wymagania

- **Git**
- **Docker** z pluginem **Compose** (`docker compose version` działa)

### Windows

- [Docker Desktop](https://docs.docker.com/desktop/)
- [Git for Windows](https://git-scm.com/download/win)

Jeśli PowerShell blokuje skrypty:

```powershell
Set-ExecutionPolicy -Scope CurrentUser RemoteSigned
```

### Linux (np. Ubuntu)

```bash
sudo apt update
sudo apt install -y git docker.io docker-compose-v2
sudo usermod -aG docker "$USER"
# wyloguj się i zaloguj ponownie
```

## Uruchomienie

### Windows (PowerShell)

```powershell
cd C:\Users\MARCINS\path\do\Testorbiteka
.\scripts\run-orbiteus.ps1
```

### Linux / macOS

```bash
cd /ścieżka/do/Testorbiteka
chmod +x scripts/run-orbiteus.sh
./scripts/run-orbiteus.sh
```

Opcjonalnie inne źródło (fork):

```bash
export ORBITEUS_URL="https://github.com/TWOJ_FORK/orbiteus.git"
./scripts/run-orbiteus.sh
```

## Po starcie (domyślnie)

| Co | Adres |
|----|--------|
| Aplikacja (UI) | http://localhost:3000 |
| API / Swagger | http://localhost:8000/api/docs |
| Login (dev) | `admin@example.com` / `admin1234` |

## Tło (bez terminala na pierwszym planie)

W katalogu `orbiteus/`:

```bash
docker compose up -d --build
docker compose logs -f
```

Stop:

```bash
docker compose down
```

## Na VPS (dostęp z zewnątrz)

Otwórz porty **3000** i **8000** (firewall + panel hostingu) albo użyj **SSH tunelu** z PC:

```bash
ssh -L 3000:127.0.0.1:3000 -L 8000:127.0.0.1:8000 user@TWOJE_IP
```

Potem na PC: http://localhost:3000

## Problemy

- **Port zajęty** — zamknij inny proces na 3000/8000 albo zmień w `orbiteus/docker-compose` / `.env` (według dokumentacji Orbiteusa).
- **Brak uprawnień Docker (Linux)** — użytkownik w grupie `docker`, po `usermod` wymagany re-login.
- **Stary Docker** — zainstaluj Compose v2 (`docker compose`, nie tylko `docker-compose`).

Oficjalny quick start: [orbiteus/orbiteus README](https://github.com/orbiteus/orbiteus).
