# VPS — plik z hasłem

1. Skopiuj szablon:  
   `cp config/vps-credentials.env.example config/vps-credentials.env`
2. Otwórz `config/vps-credentials.env` i wpisz **`VPS_SSH_PASSWORD`** (oraz ewentualnie popraw `VPS_SSH_USER`, jeśli nie jest `root`).
3. **Nie dodawaj** `vps-credentials.env` do gita — jest ignorowany.

## Przykład SSH (bez hasła w historii poleceń)

Lepiej ustawić klucz SSH niż hasło w pliku. Jeśli tymczasowo używasz hasła z pliku, narzędzia typu `sshpass` czytają je ze zmiennej wczytanej z env:

```bash
set -a
source config/vps-credentials.env
set +a
ssh -p "${VPS_SSH_PORT:-22}" "${VPS_SSH_USER}@${VPS_HOST}"
```

## Bezpieczeństwo

Jeśli hasło trafiło kiedykolwiek do czatu lub do repozytorium — **zmień je w panelu VPS** i użyj nowego tylko w lokalnym `vps-credentials.env`.
