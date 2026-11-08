# GZA core — Zigbee radio layer for GZA

GZA core is the Zigbee radio layer of GZA. It is one of the four parts of GZA, the GrandeurSmart (GS) Zigbee service; see grandeursmart-zigbee-automation for the whole service.

This branch, `gza-2.14.3`, is the **GZA 2.14.3 candidate** (base 11.2.0). Maintained by Mainlogix Technology for GrandeurSmart.

| Field | Value |
|---|---|
| Document ID | GS-GZA-CORE |
| Title | GZA core — Zigbee radio layer for GZA |
| Audience | GS engineers and reviewers |
| Owner | RADIOS (Mainlogix Technology for GrandeurSmart) |
| Status | Candidate (branch gza-2.14.3) |
| Applicable versions | GZA 2.14.3; gza-core base 11.2.0 |
| Source revision | see git history; tag of each release |
| Last validation | 2026-11-08, unit suite (locally reproduced); GZA overlay 904b2bbd |
| Review trigger | any change to contracts, configuration, operational actions or the pinned base version |

## 1. Purpose and boundaries

- Talks to the gateway's Zigbee coordinator (Silicon Labs EZSP, adapter `ezsp`) over the serial port.
- Forms and keeps the Zigbee network, admits joining devices while joining is open, and interviews them.
- Sends and receives Zigbee cluster messages for the device library (`gza-core-libs`), and keeps the device
  database and network backup on the gateway.

**Not here:** the GZA service itself (grandeursmart-zigbee-automation), the gateway start code (GSLocalBackend `run.sh`), GS core.

## 2. Ownership

Maintained by Mainlogix Technology for GrandeurSmart. Report issues in this repository's GitHub Issues; for GZA as a whole, GS staff use
grandeursmart-zigbee-automation.

| Role | Who |
|---|---|
| Accountable team | RADIOS (radio services), Mainlogix Technology for GrandeurSmart |
| Reviewer | RADIOS and R2 for GZA changes |
| Support route | this repository's issues (templates: defect, task, change proposal) |

## 3. Source provenance

- Derived from the open-source zigbee-herdsman project (https://github.com/Koenkk/zigbee-herdsman), base **11.2.0**, upstream commit `c1a54e3d5285`.
- This branch, `gza-2.14.3`, is the **GZA 2.14.3 candidate**. The default branch `gs` holds the version used by
  GZA 1.35.1.
- The package is `gza-core`. Lockfiles still list `zigbee-herdsman` (compatibility identifier, unchanged by design). The GS changes on this branch are names and repository links only; LICENSE and the copyright notices in the code are unchanged.

## 4. Supported environment

| Item | Value |
|---|---|
| Runs in | the GZA container on the GS gateway (linux/arm64), Node.js 24 from the pinned base image |
| Development and tests | Linux, Node.js 24, pnpm (version from `package.json` `packageManager`) |

## 5. Setup and secrets

No secrets. The package has no configuration of its own; GZA's configuration is written by GSLocalBackend `run.sh`
on the gateway. Never commit gateway data (device addresses, network keys, databases).

## 6. Build and run

The gateway does not build from this branch. It runs a pinned base image with the GZA overlay (`libs-2.14.3.tgz`)
mounted over it, and `gza-core` is one of the packages in that overlay. The overlay is built byte for byte by
grandeursmart-zigbee-automation `gza/build_libs.py` (a private GrandeurSmart repository, GS team access):
`python3 gza/build_libs.py /tmp/gza-build` (Python 3.9+, Node.js 24 on PATH).

- Pinned base image: `koenkk/zigbee2mqtt@sha256:f09106ecf103a8ab33cf96cae9d7eee56f1da0000682fa754cab37f02b530910` (linux/arm64).
- Expected result: sha256 `904b2bbd51cb67cc130f07596f543745bf3d833ba65c2f2b18c4290b1eb9fbd5` (the script prints MATCH).

This branch is the matching source, for review and provenance. To run its tests: `bash tests/run_all.sh`.

## 7. Code map

Upstream layout, unchanged apart from names and links: `src/` (sources), `test/` (upstream unit suite),
`package.json`. GS additions: `README.md`, `CHANGELOG.md`, `SECURITY.md`, `AGENTS.md`, `docs/`, `.github/`
(PR and issue templates, `workflows/gs-ci.yml`), `tests/run_all.sh`, `tools/check_standard.sh`, `VERSION`.

## 8. Contracts

- Package name `gza-core`; its public API is the upstream API unchanged.
- The package is `gza-core`. Lockfiles still list `zigbee-herdsman` (compatibility identifier, unchanged by design). The GS changes on this branch are names and repository links only; LICENSE and the copyright notices in the code are unchanged.
- Compatibility identifiers used by GZA stay unchanged by design: MQTT base topic `zigbee2mqtt`, discovery
  prefix `homeassistant`.

## 9. Verification

`bash tests/run_all.sh` (install with the lockfile, then the upstream vitest suite). CI (`.github/workflows/gs-ci.yml`, "GS CI") runs it with
`bash tools/check_standard.sh` on every pull request. GZA as a whole is verified in grandeursmart-zigbee-automation
(overlay build, unit suite with the GS packages, device files) and by the GSLocalBackend first-boot test on the lab
gateway. See `docs/testing.md`.

## 10. Debugging

GZA log on the gateway (`docker logs` of the GZA container). Reproduce off-device with the unit suite. Never paste
device addresses, network keys or databases into issues.

## 11. Release and recovery

GSLocalBackend's `run.sh` selects the GZA version from the image tag in `env.sh`; GSLocalBackend
`tools/gza/gza_image_test.sh` captures data before an update and rolls back to 1.35.1.
**Status: candidate.** Not merged until the OS image first-boot test passes on the lab gateway.

## 12. Maintenance

To move to a new base release, follow "Moving to a new base release" in the grandeursmart-zigbee-automation
README: this repository gets a branch from `gs` with the new base sources and the same GZA names. Review this README
when the base version, the names or the build change.

## Credits and licence

GZA core is derived from the open-source zigbee-herdsman project (part of the zigbee2mqtt project) and its contributors. Licence: MIT, see `LICENSE`. Copyright notices in the code are unchanged.
