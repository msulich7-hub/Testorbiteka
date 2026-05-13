#!/usr/bin/env bash
# Uruchom Orbiteusa (Docker) obok katalogu Testorbiteka: ../orbiteus
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
ORBITEUS_DIR="$(cd "$REPO_ROOT/.." && pwd)/orbiteus"
ORBITEUS_URL="${ORBITEUS_URL:-https://github.com/orbiteus/orbiteus.git}"

if ! command -v git >/dev/null 2>&1; then
  echo "Brak git. Zainstaluj: sudo apt install git  (lub brew install git)"
  exit 1
fi

if ! docker compose version >/dev/null 2>&1; then
  echo "Brak 'docker compose'. Zainstaluj Docker Engine + Compose (plugin)."
  exit 1
fi

if [ -d "$ORBITEUS_DIR" ] && [ ! -d "$ORBITEUS_DIR/.git" ]; then
  echo "Katalog istnieje, ale to nie jest repo git — usuń lub zmień: $ORBITEUS_DIR"
  exit 1
fi

if [ ! -d "$ORBITEUS_DIR" ]; then
  echo "Klonuję Orbiteus do: $ORBITEUS_DIR"
  git clone "$ORBITEUS_URL" "$ORBITEUS_DIR"
fi

cd "$ORBITEUS_DIR"

if [ ! -f .env ]; then
  if [ -f .env.example ]; then
    cp .env.example .env
    echo "Utworzono .env z .env.example — przed produkcją zmień SECRET_KEY i hasła."
  fi
fi

echo "Start (pierwszy raz może potrwać kilka minut)..."
docker compose up --build
