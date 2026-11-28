import { defineConfig } from "astro/config";
import sitemap from "@astrojs/sitemap";

export default defineConfig({
  site: "https://foqui.theboringbuilders.xyz",
  integrations: [sitemap()],
  compressHTML: true,
});
