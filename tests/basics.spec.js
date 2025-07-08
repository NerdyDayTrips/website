// @ts-check
import { test, expect } from '@playwright/test';

test('has title', async ({ page }) => {
  await page.goto('http://localhost:61276/');

  // Expect a title "to contain" a substring.
  await expect(page).toHaveTitle(/Nerdy Day Trips/);
});

test('about link', async ({ page }) => {
  await page.goto('http://localhost:61276/');

  // Click the get started link.
  await page.getByRole('link', { name: 'About' }).click();

  // Expects page to have an About heading.
  await expect(page.locator("#post-header").getByRole('heading', { name: 'About Nerdy Day Trips' })).toBeVisible();
});
