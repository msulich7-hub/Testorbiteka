#!/usr/bin/env python3
"""Smoke-click GitHub Pages-style docs under baseurl; capture >=10 screenshots."""
import asyncio
from pathlib import Path

from playwright.async_api import async_playwright

BASE = "http://127.0.0.1:9876/Testorbiteka"
OUT = Path("/workspace/artifacts/gh-pages-smoke")
OUT.mkdir(parents=True, exist_ok=True)


async def shot(page, name: str, full_page: bool = False) -> None:
    path = OUT / name
    await page.screenshot(path=str(path), full_page=full_page)
    print(path)


async def main() -> None:
    async with async_playwright() as p:
        browser = await p.chromium.launch(headless=True)
        context = await browser.new_context(
            viewport={"width": 1280, "height": 800},
            locale="pl-PL",
        )
        page = await context.new_page()

        await page.goto(f"{BASE}/", wait_until="networkidle")
        await shot(page, "01_home_viewport.png")
        await shot(page, "02_home_fullpage.png", full_page=True)

        # Nav: megadesign
        await page.get_by_role("link", name="Orbiteus CRM — megadesign").first.click()
        await page.wait_for_load_state("networkidle")
        await shot(page, "03_crm_after_nav_click_viewport.png")
        await shot(page, "04_crm_fullpage.png", full_page=True)

        await page.evaluate("window.scrollTo(0, document.body.scrollHeight / 3)")
        await shot(page, "05_crm_scrolled_third.png")

        await page.evaluate("window.scrollTo(0, document.body.scrollHeight * 2 / 3)")
        await shot(page, "06_crm_scrolled_two_thirds.png")

        # Internal link on megadesign page (GitHub orbiteus)
        gh = page.get_by_role("link", name="Orbiteus", exact=True).first
        if await gh.count():
            await gh.hover()
            await shot(page, "07_crm_hover_github_orbiteus_link.png")

        # Back to start via nav
        await page.get_by_role("link", name="Start").first.click()
        await page.wait_for_load_state("networkidle")
        await shot(page, "08_home_after_start_click.png")

        # Table row link to ideas
        await page.get_by_role("link", name="Co budować na Orbiteus — analiza").click()
        await page.wait_for_load_state("networkidle")
        await shot(page, "09_ideas_fullpage.png", full_page=True)

        await page.evaluate("window.scrollTo(0, 900)")
        await shot(page, "10_ideas_scrolled.png")

        # Mobile viewport same flow
        mobile = await browser.new_context(
            viewport={"width": 390, "height": 844},
            is_mobile=True,
            locale="pl-PL",
        )
        mp = await mobile.new_page()
        await mp.goto(f"{BASE}/", wait_until="networkidle")
        await shot(mp, "11_mobile_home.png")

        await mp.get_by_role("link", name="Orbiteus CRM — megadesign").first.click()
        await mp.wait_for_load_state("networkidle")
        await shot(mp, "12_mobile_crm.png")

        await mobile.close()
        await browser.close()

    print(f"Done. {len(list(OUT.glob('*.png')))} PNG files in {OUT}")


if __name__ == "__main__":
    asyncio.run(main())
