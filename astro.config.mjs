// @ts-check

// https://astro.build/config
import { defineConfig } from 'astro/config';
import tailwind from '@astrojs/tailwind';

export default defineConfig({
  site: 'https://lizethcarosilva.github.io',
  base: '/Ingenieria_Prog.github.io',
  integrations: [tailwind()]
});