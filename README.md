# Testorbiteka

Repozytorium robocze pod pomysły i dokumentację związaną z platformą **[Orbiteus](https://github.com/orbiteus/orbiteus)** (silnik ERP/CRM / aplikacji biznesowych).

## Dokumenty

| Dokument | Opis |
|----------|------|
| [Co budować na Orbiteus — analiza](docs/ORBITUEUS-IDEAS.md) — [**Pages**](https://msulich7-hub.github.io/Testorbiteka/orbiteus-ideas/) | Skrót platformy, mocne strony i lista pomysłów na projekty. |
| [Orbiteus CRM — megadesign](docs/crm-megadesign.md) — [**Pages**](https://msulich7-hub.github.io/Testorbiteka/crm-megadesign/) | Synteza researchu wielu CRM, backlog P0/P1/P2, role, mapowanie modułów. |

### Testy (czy strona /docs buduje się poprawnie)

- **CI:** po pushu na `main` workflow **Docs site** (`.github/workflows/docs-ci.yml`) w katalogu `docs/` odpala `bundle exec jekyll build` (gem `github-pages` jak na GitHub Pages) i sprawdza, czy powstały `index.html` oraz strony `crm-megadesign` i `orbiteus-ideas`.
- **Lokalnie (Linux z Ruby):** `cd docs && bundle install && bundle exec jekyll build -d _site` — wynik w `docs/_site/`.

### Zrzuty ekranu (Playwright, opcjonalnie)

Strona Jekyll używa `baseurl: /Testorbiteka` — lokalny serwer musi serwować katalog **nadrzędny**, w którym leży podfolder `Testorbiteka` (tak jak na `github.io`). Następnie:

```bash
# 1) zbuduj stronę
cd docs && bundle exec jekyll build -d _site

# 2) serwuj (przykład)
mkdir -p /tmp/ghroot/Testorbiteka && cp -r _site/* /tmp/ghroot/Testorbiteka/
python3 -m http.server 9876 --directory /tmp/ghroot &

# 3) zrzuty (wymaga: pip install playwright && playwright install chromium)
python3 scripts/gh-pages-smoke-screenshots.py
```

Pliki trafiają do `artifacts/gh-pages-smoke/` (katalog w `.gitignore`).

### Podgląd na GitHub Pages

**Settings → Pages → Branch `main`, folder `/docs`**, potem strona po ok. minucie:

- Start: `https://msulich7-hub.github.io/Testorbiteka/`
- Analiza: `https://msulich7-hub.github.io/Testorbiteka/orbiteus-ideas/`
- Megadesign: `https://msulich7-hub.github.io/Testorbiteka/crm-megadesign/`

Jeśli zmienisz nazwę repozytorium, zaktualizuj `baseurl` w [`docs/_config.yml`](docs/_config.yml).

Upstream Orbiteus klonuj z oficjalnego repozytorium; tutaj możesz trzymać briefy produktowe i notatki pod własny fork lub moduły.
