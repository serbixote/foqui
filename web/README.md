# Foqui website

The marketing page at [foqui.theboringbuilders.xyz](https://foqui.theboringbuilders.xyz). Astro builds `web/src` into `web/dist`. Files in `web/public` are copied as-is, including the invite fallback (`join.html`) and Apple's association file.

Needs Node 20 or newer.

## Run it locally

From the repo root:

```sh
npm --prefix web ci
npm --prefix web run dev
```

Open http://localhost:4321. Edits in `web/src` reload on their own.

`/join.html` is served from `web/public` in this dev server. Paths like `/join/abc123` are not: that rewrite lives in `firebase.json` and only runs on Firebase Hosting.

## Preview the production build

```sh
npm --prefix web run build
npm --prefix web run preview
```

The built files are in `web/dist`. That folder is gitignored.

To try the `/join/*` rewrite locally, build first, then start the Hosting emulator (Firebase CLI, port 5000):

```sh
npm --prefix web run build
npx firebase-tools emulators:start --only hosting
```

## Deploy

The Firebase project is `theboringbuilders-foqui`. Hosting uploads `web/dist`. The predeploy hook in `firebase.json` installs dependencies and builds, so a separate build step is unnecessary.

```sh
npx firebase-tools login
npx firebase-tools deploy --only hosting
```

The first command is only needed once on a machine. The account needs access to the Firebase project.
