# MIMMS_pl ↔ Orbiteus — jak to spiąć

**Kontekst:** Nie mam dostępu do lokalnego folderu `C:\Users\MARCINS\Documents\oracle-ai\aplikacje\22_MIMMS_pl` z tego środowiska. Poniżej jest **uniwersalny schemat** podłączenia takiej aplikacji do [Orbiteus](https://github.com/orbiteus/orbiteus) oraz **lista tego, co warto wkleić / skopiować do repo**, żeby zrobić konkretną mapowanie encji i endpointów.

---

## Co zwykle znaczy „podłączyć Orbiteusa pod aplikację”

Orbiteus to **silnik**: Postgres + FastAPI (auto-CRUD po modułach) + Next.js (schema-driven UI) + JWT/RBAC. „Podłączenie” MIMMS może być jednym z poziomów:

| Poziom | Sens | Kiedy |
|--------|------|--------|
| **A. Moduł Orbiteus** | Encje MIMMS jako `registry.register("mimms")` — jedna baza, jeden login, UI z Orbiteusa | Chcesz **jeden system** operacyjny / CRM / backoffice |
| **B. Integracja przez API** | MIMMS zostaje osobna aplikacja; Orbiteus tylko **woła jej HTTP** lub odwrotnie (webhook, sync) | MIMMS ma **własną logikę**, której nie chcesz przepisywać |
| **C. Sam front Orbiteus, back MIMMS** | UI z `admin-ui`, dane z serwisu MIMMS przez proxy/custom router | Mało czasu na UI, ważna logika w starym backendzie |

Dla typowej „aplikacji w folderze” najczęściej startuje się od **B**, a docelowo **A**, gdy ustalisz model danych.

---

## Kroki techniczne (szkic)

1. **Sklonuj Orbiteus** obok MIMMS (osobne repo): `git clone https://github.com/orbiteus/orbiteus`.
2. **Zdefiniuj granicę:** co jest „źródłem prawdy” — baza MIMMS czy Postgres Orbiteusa? Unikaj dwóch baz bez procesu synchronizacji.
3. **Jeśli A (moduł):**
   - W `backend/modules/mimms/`: `manifest.py`, `model/domain.py`, `mapping.py`, `schemas.py`, `view/*.xml`, `security/access.yaml`, `actions.py`.
   - Po `registry.register("mimms")` dostajesz CRUD + UI + Cmd+K bez ręcznego pisania list/form.
4. **Jeśli B (integracja):**
   - W Orbiteus: `controller/router.py` w module lub osobny serwis — `httpx`/`requests` do MIMMS, mapowanie DTO → modele Orbiteusa.
   - Auth: **service user** + JWT Orbiteusa dla użytkowników, albo klucz API do MIMMS w `ir_config_param` / `.env`.
5. **Next.js:** `BACKEND_URL` wskazuje na Twój FastAPI; CORS jak w dokumentacji Orbiteusa.
6. **Tenant:** wszystkie tabele biznesowe z `tenant_id`, jeśli idziesz w multi-tenant Orbiteusa.

---

## Co potrzebuję od Ciebie (z folderu MIMMS_pl), żeby to zawęzić

Skopiuj do tego repozytorium (lub wklej treść w issue) **bez sekretów**:

- `README*` / opis projektu  
- **`package.json` / `requirements.txt` / `pyproject.toml`** — stack i porty  
- **Główny entry** (`main.py`, `app.py`, `server.js`, `docker-compose.yml`)  
- **Modele / schematy** (np. SQLAlchemy, Pydantic, Prisma, typy TS)  
- **Lista tras API** lub folder `routes/` / `api/`  

Wtedy można napisać **konkretną mapę**: tabela ↔ moduł Orbiteus, które pola, które endpointy proxy.

---

## Szybki checklist przed kodem

- [ ] Czy MIMMS ma już REST i dokumentację (OpenAPI)?  
- [ ] Czy logowanie ma być **tylko Orbiteus** (JWT), czy SSO z MIMMS?  
- [ ] Czy dane mają być **tylko w Postgres Orbiteusa**, czy MIMMS zostaje DB master?

---

## „Orbitek” jako jedna baza pod oba

Jeśli „orbitek” = Twój fork / instalacja Orbiteusa: trzymaj **jedną instancję** (Docker compose z Orbiteusa) i dodawaj moduł `mimms` **albo** osobny kontener MIMMS w tej samej sieci Docker z `BACKEND_URL` i nazwą serwisu DNS (`http://mimms:8080`).

---

*Dokument roboczy — uzupełnij po skopiowaniu fragmentów z `22_MIMMS_pl`.*
