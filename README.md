# About this fork — gza-core (GZA 2.14.3 candidate)

This repository is GrandeurSmart's fork of **[zigbee-herdsman](https://github.com/Koenkk/zigbee-herdsman)**, used by GZA,
GrandeurSmart's Zigbee service (based on zigbee2mqtt). This branch is upstream **zigbee-herdsman 11.2.0**
(tag at commit `c1a54e3d5285`), unchanged except for the GS changes below. All credit for the code goes to
the upstream authors and contributors; the licence is upstream's **MIT** (see `LICENSE`, unchanged), and
`package.json` keeps the upstream author and contributors (GrandeurSmart is recorded as `gzaMaintainer`).

### What GS changes
Names and branding only, so the packages can sit side by side with upstream ones:
`zigbee-herdsman` → `gza-core`, `zigbee-herdsman-converters` → `gza-core-libs`, `zigbee2mqtt-frontend` →
`gza-frontend`, the matching `zigbee_herdsman*` keys, and repository links pointing at the GrandeurSmart forks.
The branding commit left LICENSE, README, CHANGELOG, docs and lockfiles untouched; this section (and, in
grandeursmart-zigbee-automation, a GZA section at the top of CHANGELOG.md) was added afterwards. No device logic is changed here: GS device
converters (GS_1, GS_OWON, GS_TS0001) live in GSLocalBackend (`add-ones/gza/converters-2/`) and in
grandeursmart-zigbee-automation `gza/converters/`.

### How to build reproducibly
The overlay GZA ships (`libs-2.14.3.tgz`) is built by the `gza/` folder of
[grandeursmart-zigbee-automation](https://github.com/GrandeurSmart/grandeursmart-zigbee-automation/tree/gza-2.14.3/gza),
branch `gza-2.14.3`, from upstream's published image pinned by digest:

```
git clone --branch gza-2.14.3 https://github.com/GrandeurSmart/grandeursmart-zigbee-automation.git
python3 grandeursmart-zigbee-automation/gza/build_libs.py /tmp/gza-build   # needs Python 3.9+ and Node.js 24 on PATH
```
- Pinned image: `koenkk/zigbee2mqtt@sha256:f09106ecf103a8ab33cf96cae9d7eee56f1da0000682fa754cab37f02b530910` (linux/arm64)
- Expected sha256: `22665cd9a42e6d5a9f97d0c4deb5423ca2b60f8484bd4c81ccdf5e0b3a65c91a` (the script prints MATCH)

The overlay is taken from upstream's compiled image, not compiled from this source tree, so it matches what
upstream ships. This branch is the matching source, for review and provenance.

### How GS uses it
On the gateway GZA runs as the stock upstream zigbee2mqtt image with the GZA overlay mounted over it
(`dist/`, `node_modules/gza-core`, `gza-core-libs`, `gza-frontend`), launched by GSLocalBackend's `run.sh`.
The GZA image tag in `env.sh` selects the layout: a 1.x tag keeps the old 1.35.1 layout unchanged; tag
`2.14.3` unpacks `add-ones/gza/libs/libs-2.14.3.tgz` and loads the GS device converters from
`data/external_converters`. Rollback is the env.sh tag back to 1.35.1 plus the data captured before the
switch (`tools/gza/gza_rollback.sh`, `tools/gza/gza_image_test.sh rollback` in GSLocalBackend).

### Moving to a new upstream release
1. Check the new zigbee2mqtt release and the versions of zigbee-herdsman, zigbee-herdsman-converters and the
   frontend inside its image.
2. In grandeursmart-zigbee-automation `gza/build_libs.py`, set the new image digest; build; record the new
   sha256 in `gza/EXPECTED_SHA256`.
3. In each fork, make a branch from `gs` with an "init with <upstream version>" commit (the upstream tag's
   tracked files) and a branding commit (the same renames as `gza/gza_rebase.py`).
4. Rerun: `gza/tests` (t_conv, t_load, t_brand) on a stock+overlay tree; the GZA boot test; GSLocalBackend
   run.sh tests; `gza_image_test.sh` (capture → verify → rollback); the Home Assistant discovery comparison
   with `gza/tools`. Check whether upstream now covers any GS converter.
5. Draft PR; merge only after the OS image first-boot test passes on the lab unit.

### Status
**Candidate.** Branch `gza-2.14.3` is not merged and will not be until the OS image first-boot test passes on
the lab unit. The default branch `gs` still holds the 1.35.1-based version GZA ships today.

---

*The upstream README follows unchanged.*

# zigbee-herdsman

[![npm](https://img.shields.io/npm/v/zigbee-herdsman)](https://www.npmjs.com/package/zigbee-herdsman)

zigbee-herdsman is an open source Zigbee gateway solution with Node.js JavaScript runtime back-end.

It was originally forked from zigbee-shepherd with the goal to refactor it to improve maintainability.

# API Documentation

For automatically generated API reference documentation, see: https://koenkk.github.io/zigbee-herdsman.

# Changelog

For complete release notes, including breaking changes, see: [CHANGELOG.md](./CHANGELOG.md)

# Related projects

## Zigbee2MQTT

[Zigbee2MQTT](https://github.com/Koenkk/zigbee2mqtt) is a Zigbee to MQTT gateway. It bridges events and allows you to control your Zigbee devices via MQTT. Allows you to use your Zigbee devices without the vendors or propritary and closed sources bridges or gateways. Zigbee2MQTT also keeps track of the state of the system and the capabilities of connected devices. It uses zigbee-herdsman and [zigbee-herdsman-converters](https://github.com/Koenkk/zigbee-herdsman-converters) as modules to handle low-level core Zigbee communication.

## ioBroker

[ioBroker](https://github.com/ioBroker) is an home automation integration platform that is focused on Building Automation, Smart Metering, Ambient Assisted Living, Process Automation, Visualization and Data Logging. It uses zigbee-herdsman for its Zigbee integration.
