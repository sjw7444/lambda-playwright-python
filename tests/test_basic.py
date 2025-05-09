"""Basic browser automation tests using Playwright."""

from playwright.sync_api import sync_playwright


def test_browser_launch():
    """Test that browser can be launched and navigate to example.com."""
    with sync_playwright() as p:
        browser = p.chromium.launch()
        page = browser.new_page()
        page.goto("https://example.com")
        assert page.title() == "Example Domain"
        browser.close()
