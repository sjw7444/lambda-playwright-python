"""Basic browser automation tests using Playwright."""

from playwright.sync_api import sync_playwright


def test_playwright_installation():
    """Test that Playwright and Chromium are properly installed."""
    with sync_playwright() as p:
        browser = p.chromium.launch(headless=True)
        assert browser is not None
        browser.close()
