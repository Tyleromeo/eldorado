# Palmarès

*The work behind your records.*

A personal training-intelligence dashboard for cyclists, built on the Strava API.
It pulls your full activity history and turns it into power analysis, KOM and
Top 10 tracking, gear and streak stats, weather-aware ride planning, and route
building.

## Structure

The entire app is a single file: **`index.html`** — markup, styles, and all
application JavaScript. There is no build step, no bundler, and no
`package.json`. Open it, edit it, ship it.

`privacy.html` is the privacy policy that the Strava API terms require a
registered application to publish.

## The five sections

| Section | What it does |
| --- | --- |
| **Today** | The daily view — training readiness, today's opportunity, upcoming club events |
| **Train** | Power curve, zone distribution, year-over-year totals, goals, aero analysis |
| **Palmarès** | Complete KOM and Top 10 history, built from a full scan of every activity |
| **Scout** | Where to ride — tailwind segments, segment-hunter map, route builder, road reports, forecast |
| **Log** | Activity history, heatmap, ride-crew collaborators, gear mileage, streaks |

## Running it

It is a static file, but it must be **served over http** rather than opened via
`file://` — the Strava OAuth redirect will not complete from a `file://`
origin. Any static server works:

```sh
python3 -m http.server 8000
# then open http://localhost:8000
```

Without authentication you will only reach the "Connect with Strava" screen.

## Data and storage

All data stays in the browser. Tokens, settings, and cached API responses live
in `localStorage` under `ed_*` keys (`ed_access_token`, `ed_settings`,
`ed_collapsed`, …). There is no backend and no server-side storage.

> The `ed_` prefix is a holdover from the app's former name. **Do not rename
> these keys** — changing them signs the user out and discards every cached
> activity and setting.

## External services

- **Strava API** — activities, segments, clubs, gear, athlete profile
- **Apple WeatherKit**, **weather.gov**, **Open-Meteo** — forecast and wind
- **Mapbox**, **Leaflet** + **leaflet.heat** — map tiles and heatmaps
- **OSRM** (`router.project-osrm.org`) — route snapping
- **Open-Elevation** — elevation profiles
- **SBRA** — local road and group-ride reports

Chart.js 4.4.0 and Leaflet 1.9.4 are loaded from CDN.

## iOS wrapper

The site is also wrapped in a native iOS WebView. The page talks to it over
`window.webkit.messageHandlers.palmaresNative`, and sets a `native-app` body
class when `window.isPalmaresNativeApp` is present.

Both checks fall back to the older `eldoradoNative` / `isEldoradoNativeApp`
names so that a freshly deployed page still works against an installed app
build that predates the rename. Keep the fallbacks until every such build is
retired.

## Editing

Because there is no test suite or build, the only guard against a broken deploy
is checking the script yourself after an edit:

```sh
END=$(awk 'NR>1100 && /^<\/script>/{print NR; exit}' index.html)
sed -n "1101,$((END-1))p" index.html > /tmp/main.js && node --check /tmp/main.js
```
