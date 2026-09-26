# LegacyBrew bottles

This Homebrew tap distributes selected bottles for older macOS releases. Formulae are derived from Homebrew Core; Homebrew still resolves dependencies and performs installation.

## Verified snapshot

The initial release covers macOS Sonoma arm64 with the default `/opt/homebrew` prefix:

| Formula | Version | Managed runtime dependency |
| --- | --- | --- |
| `sqlite` | 3.53.4 | `xiaoran007/bottles/readline` |
| `readline` | 8.3.6 | None |

The public GHCR bottles were installed from a request for only `xiaoran007/bottles/sqlite` in a clean Sonoma arm64 Tart VM. Both formulae passed linkage checks and upstream formula tests. See [`registry/v1/catalog.json`](registry/v1/catalog.json) for the exact upstream formula identities, bottle hashes, OCI digests, and verification summary.

## Install

```sh
brew tap xiaoran007/bottles
brew trust --formula xiaoran007/bottles/readline
brew trust --formula xiaoran007/bottles/sqlite
brew install xiaoran007/bottles/sqlite
```

Homebrew requires explicit trust for each third-party formula in the dependency closure. The commands above trust only these formulae, rather than every formula in this tap. The `sqlite` formula declares `xiaoran007/bottles/readline` explicitly, so Homebrew selects this tap's `readline` even though Core has a formula with the same name.

This snapshot records the Homebrew Core formulae at publication time. If Core changes later, these bottles are not an exact match for the newer Core formulae. Existing installations of same-name Core formulae are not automatically migrated. Other macOS releases, architectures, and prefixes have not been verified by this project.

## Provenance and license

The derived formulae retain the upstream source and build logic. Distribution metadata and managed dependency sources are changed, and Core-only `no_autobump!` maintenance declarations are removed with the original text recorded in the [source project's derivation evidence](https://github.com/xiaoran007/LegacyBrew). Homebrew Core formulae are distributed under the BSD 2-Clause License; see [`LICENSE-CORE.txt`](LICENSE-CORE.txt).
