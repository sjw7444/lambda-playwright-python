"""Basic browser automation tests using Playwright."""

from playwright.sync_api import sync_playwright

LAUNCH_ARGS = [
    "--no-sandbox",
    "--disable-setuid-sandbox",
    "--disable-dev-shm-usage",
    "--disable-gpu",
    "--no-zygote",
    "--single-process",
]


def test_playwright_installation():
    """Test that Playwright and Chromium are properly installed."""
    with sync_playwright() as p:
        browser = p.chromium.launch(headless=True, args=LAUNCH_ARGS)
        assert browser is not None
        browser.close()
