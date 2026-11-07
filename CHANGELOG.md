# Changelog

GS entries only. Base release notes: https://github.com/Koenkk/zigbee-herdsman/releases (this branch is based on release 11.2.0).

## gza-core 11.2.0 for GZA 2.14.3 (candidate, branch gza-2.14.3) — 2026-11-07

- Base 11.2.0 (commit `c1a54e3d5285`).
- Package named `gza-core`, with GZA names for the other GZA packages and repository links to the GrandeurSmart
  repositories. No other code changes.
- Repository links fixed: `package.json` `repository`, `bugs` and `homepage`, and links in source comments
  and messages, point at the real GrandeurSmart repositories (the earlier rename order produced links to
  repositories that do not exist). Links only; no code logic changed.
- LICENSE and copyright notices unchanged; `package.json` keeps the original author and contributors, with
  Mainlogix Technology recorded as `gzaMaintainer`.
- Shipped inside the GZA overlay `libs-2.14.3.tgz` (sha256 `b8a05f2befcb…`), built by
  grandeursmart-zigbee-automation `gza/build_libs.py`.
- Status: candidate; merged only after the OS image first-boot test passes on the lab gateway.
