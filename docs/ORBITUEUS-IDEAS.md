---
layout: page
title: "Orbiteus — co budować"
permalink: /orbiteus-ideas/
---

Ten dokument jest krótką analizą repozytorium **[orbiteus/orbiteus](https://github.com/orbiteus/orbiteus)** (silnik do budowy własnych ERP/CRM i aplikacji biznesowych) oraz **propozycjami projektów**, które naturalnie pasują do tej platformy.

---

## Czym jest Orbiteus (w skrócie)

- **Nie jest gotowym produktem**, tylko **platformą**: instalujesz silnik, rejestrujesz moduły (`registry.register("...")`), konfigurujesz UI — powstaje aplikacja dopasowana do procesów.
- **Stack**: Python 3.12 + FastAPI + SQLAlchemy async, PostgreSQL 16, Alembic, JWT + RBAC, Next.js 14 (App Router) + Mantine 8; opcjonalnie AI (Claude) do rerankingu w Command Palette.
- **Auto-propagation**: jedna rejestracja modułu → tabele, REST CRUD, OpenAPI, schema-driven UI (lista/formularz/kanban), akcje w Command Palette (Cmd+K).
- **Multi-tenant**: `tenant_id` na tabelach, izolacja na poziomie repozytoriów.
- **Roadmapa** (z README upstream): faza 4 to m.in. rozszerzenia, Smart Search, SSE, audit, moduły biznesowe (HR, Project, Inventory…).

Źródło opisu i architektury: [README orbiteus/orbiteus](https://github.com/orbiteus/orbiteus).

---

## Co w Orbiteus jest „unikalnym hakiem” pod nowe pomysły

| Mechanizm | Dlaczego to ważne dla pomysłów |
|-----------|--------------------------------|
| **Moduły + manifest** | Każda nowa domena to osobny pakiet z jasnym kontraktem — łatwo utrzymać i skalować. |
| **RBAC + Actions** | Każda funkcja biznesowa może być wykrywalna z palety poleceń i kontrolowana uprawnieniami — dobre pod **AI-native** i ergonomiczny UX. |
| **Schema-driven UI** | Szybko pokazujesz MVP bez pisania setek komponentów na model. |
| **PostgreSQL + tenant isolation** | Nadaje się pod SaaS B2B, agencje, sieci oddziałów. |

---

## Propozycje — co ciekawego zbudować (uporządkowane)

### A. Szybkie „vertical SaaS” (najlepszy fit na dziś)

Idee, gdzie **CRUD + widoki + RBAC + Cmd+K** wystarczą na MVP, a rozszerzenia dodasz później.

1. **CRM dla nisz** — np. studia projektowe, agencje marketingowe, deweloperzy sprzedaży: leady, projekty, oferty, timeline aktywności (gdy roadmapa doda activities/graph).
2. **Mały TMS / dispatch** — zlecenia, pojazdy, kierowcy, statusy tras (upstream wprost podaje TMS jako przykład).
3. **Studio / agencja kreatywna** — briefy, klienci, zadania, szablony dokumentów (później integracje).
4. **Sala / sieć obiektów sportowych** — członkostwa, karnety, trenerzy (też w README jako przykład).

### B. Operacje i magazyn

5. **Lekki WMS** — stany, przyjęcia/wydania, minimalne stany, powiązanie z prostą sprzedażą B2B.
6. **Asset registry** — sprzęt IT, flota, serwis: aktywa, przypisania, historia zdarzeń (audit w fazie 4 wzmocni sens).

### C. Produkty „pod AI” (wykorzystanie Actions + opcjonalnie LLM)

7. **„Asystent operacyjny” dla małej firmy** — wszystkie kluczowe akcje (`Action`) opisane słowami kluczowymi PL/EN; użytkownik otwiera Cmd+K zamiast menu; z czasem bogatszy reranking przez API.
8. **Wewnętrzna baza wiedzy + encje** — encje w Postgresie + akcje typu „otwórz rekord X”; docelowo dopięcie pod Smart Search (faza 4).

### D. Rozwój samej platformy (jeśli chcesz kontrybuować do upstream)

9. **Moduł szablonowy** — np. `inventory` lub `projects` zgodnie ze strukturą z README (manifest, domain, mapping, views, `access.yaml`).
10. **Integracje** — webhooki lub synchronizacja z kalendarzem / pocztą / płatnościami jako osobne warstwy obok auto-CRUD (bez łamania module isolation).

---

## Jak wybrać jeden pierwszy projekt

- **Masz domenę z jasnymi encjami i procesami?** → vertical SaaS (A) albo operacje (B).
- **Chcesz efekt „wow” w UX bez ogromu frontendu?** → postaw na **Actions + RBAC** (C).
- **Chcesz być częścią ekosystemu Orbiteus?** → moduł lub integracja (D).

---

## Przydatne linki

- Repozytorium: [github.com/orbiteus/orbiteus](https://github.com/orbiteus/orbiteus)
- Dokumentacja architektury w upstream: `docs/ARCHITECTURE.md` (w repozytorium Orbiteus)
- Ten folder (`docs/`) w tym repozytorium służy jako **Twoja notatka robocza** — możesz ją rozszerzać o wybrany kierunek (np. jedna wybrana nisza + lista encji).

---

*Dokument wygenerowany w kontekście analizy; nie zastępuje oficjalnej dokumentacji Orbiteus.*
