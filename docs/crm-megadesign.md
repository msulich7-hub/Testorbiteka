---
layout: page
title: "Orbiteus CRM — megadesign"
permalink: /crm-megadesign/
---

Dokument zbiera **wyniki równoległego researchu** (10 perspektyw: Salesforce, HubSpot, Pipedrive, Zoho, monday Sales CRM, Freshsales, Dynamics 365 Sales, Close, Attio, Bitrix24) oraz **5 ról** (klient B2B, handlowiec/SDR, szef sprzedaży, CEO, marketing demand gen). Celem jest odpowiedź na pytanie: **co „genialnego” można zbudować jako CRM na silniku Orbiteus** — bez kopiowania monolitu, z jasnym MVP i przewagą modularną.

---

## 1. Metodologia (skrót)

- **10 subagentów** — każdy przeanalizował inny ekosystem CRM i wyciągnął: model danych, automatyzacje, UX, integracje, **pomysły przenośne** na FastAPI + Postgres + Next.js + multi-tenant + schema-driven UI.
- **5 subagentów** — każdy grał **jedną rolę** i odpowiedział po polsku na pytania priorytetów, ryzyk i „killer feature”.
- **Ta synteza** — agregacja bez dublowania enciklopedii; decyzje produktowe w formie list i macierzy.

---

## 2. Co wynosimy z „wielkiej dziesiątki” (jedna tabela)

| Źródło | Esencja do skopiowania (idea, nie 1:1) |
|--------|----------------------------------------|
| **Salesforce** | Warstwa prognozy (kategorie, hierarchia, override z audytem), runtime automatyzacji z kolejnością triggerów, „report types” jako bezpieczne joiny, zdarzenia integracyjne (outbox). |
| **HubSpot** | Wspólny słownik lifecycle (MQL/SQL/…), asocjacje rekordów, timeline jako prawda operacyjna, lekki attribution (v1: pierwszy/ostatni touch). |
| **Pipedrive** | Pipeline-first, **rotting** (przeterminowanie per etap), aktywność jako oś dnia, osobny **Lead → Deal**, cele i forecast bez przepychu enterprise. |
| **Zoho** | **Blueprint**: stany i przejścia z guardami (nie dowolna edycja etapu), scoring jako pola + triggery, terytoria i FX jako moduły. |
| **monday Sales CRM** | Karta rekordu jak **Item Card** (widgety), kolumny relacji dwukierunkowe, widoki zapisane per user, automatyzacje „przy zmianie etapu”. |
| **Freshsales** | Telephony jako adapter (port), **360° timeline**, workflow szablony dla SMB, warstwa AI: podsumowania, ryzyko deala, dedupe. |
| **Dynamics** | Podsumowanie rekordu + „co się zmieniło”, lekka prognoza z kategoriami, meeting prep, audyt pól finansowych i eksportu — **wybrane**, nie cały Purview. |
| **Close** | **Smart Views = kolejki pracy**, unified inbox, sekwencje wielokanałowe, Lead vs Opportunity z wagą pipeline — przy **ostrożności EU** ( dial/SMS/zgody). |
| **Attio** | Obiekty + **listy** z polami tylko na liście, stabilne slugi API, historia wartości pól, AI jako **trwałe atrybuty** + workflow z historią uruchomień. |
| **Bitrix24** | **Jeden timeline** na karcie, omnichannel jako kolejki + podpięcie do CRM, automatyzacja per etap — ale architektonicznie u nas: rozdzielenie conversation vs CRM vs workflow. |

---

## 3. Złocone funkcje dla „Orbiteus CRM” — backlog koncepcyjny

### P0 (MVP pilota — musi być)

1. **Tenant + RBAC + audyt** na kluczowych polach (kwota, etap, owner, eksport).
2. **Firma, kontakt, okazja** z asocjacjami (wiele osób przy dealu); opcjonalnie **lead** przed konwersją.
3. **Pipeline** (etapy, wartość, data zamknięcia, właściciel), historia zmian etapu.
4. **Zadania + timeline** (działania, notatki, zmiany pól) — „pusty rekord” niemożliwy jako norma.
5. **Import CSV**, świadome duplikaty (minimum: ostrzeżenie / prosty merge).
6. **Webhook lub REST** do integracji + eksport danych (ścieżka wyjścia).
7. **Cmd+K / Actions** — tworzenie rekordów, skoki, **priorytetyzowane akcje** zgodne z RBAC (Orbiteus-native).

### P1 („naprawdę konkurencyjny” CRM na Orbiteus)

1. **Rotting / SLA per etap** + widok „zepsute/stare deale” (jak Pipedrive).
2. **Listy i kolejki pracy** (filtr zapisany = kolejka „dzisiaj”) — blisko Close + Attio.
3. **Proces sprzedaży**: przejścia etapów z **exit criteria** (Blueprint-light).
4. **Marketing–sales handoff**: MQL/SQL, źródło, UTM, snapshot pierwszego/ostatniego touch (bez pełnego multitouch).
5. **Moduł kampanii lekki**: initiative → podpięte leady/deale → **prosty contributed pipeline** (reguła 90 dni itd.).
6. **Layout / widoki schema-driven** — warianty pól per rola (Canvas-light po stronie config).
7. **Telephony port** — integracja z Twilio/similar; log rozmowy na timeline (Freshsales pattern).

### P2 (przewaga „genialna”, ale po dowiezieniu P0/P1)

1. **Warstwa prognozy**: commit/best/upside + rollup managerski (Salesforce-light).
2. **Silnik automatyzacji** z wersjonowaniem, kolejką, **inspectable runs** (co się wykonało i dlaczego).
3. **AI**: podsumowanie rekordu, „next best action” z uzasadnieniem, **MEDDIC z call notes** jednym potwierdzeniem (handlowiec).
4. **AI attributes** jako pola (Attio), nie tylko chat.
5. **Terytoria / FX** jako osobne moduły (Zoho-style).
6. **Omnichannel** — konwersacje jako adaptery + kolejki (Bitrix idea, czysta architektura).

---

## 4. „Genialny CRM na Orbiteus” — definicja syntetyczna

Po roli **szefa sprzedaży**: system jest genialny, gdy **każda poniedziałkowa decyzja wychodzi z jednego ekranu z drill-downem do prawdy historycznej deala**, a handlowiec **woli zapisać rzeczywistość w CRM niż go obejść**, bo to **skraca dzień i podnosi szansę zamknięcia**.

Po **CEO**: wygrywacie, jeśli w ~90 dni widać **mierzalnie wyższą konwersję i krótszy cykl** przy niższym koszcie utrzymania procesu na danych niż status quo SaaS.

Technicznie Orbiteus to **registry modułów + schema-driven UI + Actions** — „genialność” to **spójny moduł decyzji**: scoring/kolejka z **regułami biznesowymi i audytem**, a nie tylko dashboardy.

---

## 5. Ryzyka (zwłaszcza EU)

- **Predictive dialer, SMS masowe** — domyślne tryby jak w US mogą być nielegalne lub toksyczne dla marki; produkt powinien być **consent-first** i per kraj.
- **Nagrywanie rozmów** — polityki pracownicze i RODO; funkcja jako **opt-in + retencja**.
- **Złożoność Bitrix-style** — omnichannel + SPA bez architektury eventowej = dług; u Was: **Conversation** i **Workflow** jako osobne granice modułów.

---

## 6. Perspektywy 5 ról (skrót wyników)

### Klient B2B (zakupy)

- **MVP do pilota**: SSO-ready roadmapa, RODO/DPA, pipeline + kontakty + timeline + minimalna automatyzacja + API + eksport.
- **Deal-breakery**: brak izolacji tenantów, brak audytu, lock-in bez API, Cmd+K bez kontroli workflow.
- **Killer idea**: jeden **system decyzji** nad rekordem — sygnały → scoring/kolejka z uzasadnieniem i regułami firmy.

### Handlowiec / SDR

- Dzień = **kolejka + Cmd+K + logowanie wyniku jednym kliknięciem**; lifecycle widoczny bez grzebania w raportach.
- **Wow AI**: po rozmowie — **MEDDIC w punktach + proponowane next step + zadanie** z jednym potwierdzeniem.

### Szef sprzedaży

- Dashboard: pipeline vs cel, velocity, konwersja etapów, forecast vs commit, aktywności vs obietnice, ryzyka dużych deali.
- Proces: checklisty exit (Zoho) + język forecast (SF Path) + lifecycle bez dublowania pól (HubSpot).

### CEO

- Własny CRM = **TCO, proces pod model, dane, integracja z Orbiteus, możliwość monetyzacji produktu**.
- Przewaga: **nisza, własne dane/model, głęboka integracja, szybkość zmian**.

### Marketing (demand gen)

- v1: lead z MQL/SQL, UTM + snapshot, kampanie lekkie, zgody, handoff z notatką.
- Fantazja modułu: **kampania → contributed pipeline / revenue** prostą regułą, bez budowania drugiego HubSpota.

---

## 7. Mapowanie na Orbiteus (moduły)

| Obszar | Propozycja modułów / manifestów |
|--------|-----------------------------------|
| Rdzeń CRM | `crm_parties` (firma, osoba), `crm_pipeline` (lead, deal, etapy), `crm_activities` |
| Proces | `crm_blueprint` lub pola stanu + przejścia w core workflow |
| Marketing | `crm_attribution` (lekkie), `crm_campaigns` |
| Wykonanie | `crm_queues` (saved views + digest), `crm_docs` (oferty, track, e-sign — opcjonalnie) |
| AI | `crm_copilot` — tylko pola audytowalne i polityki tenant |

---

## 8. Linki zewnętrzne

- Silnik: [github.com/orbiteus/orbiteus](https://github.com/orbiteus/orbiteus)
- Ten dokument nie zastępuje licencji ani dokumentacji upstream — to **brief produktowy** pod Wasz fork / moduły.

---

*Wygenerowano w procesie: 10 researchów CRM + 5 person (Composer). Data: 2026-05-02.*
