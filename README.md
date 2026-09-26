# LegacyBrew bottles

This Homebrew tap distributes selected bottles for older macOS releases. Formulae are derived from Homebrew Core; Homebrew still resolves dependencies and performs installation.

## Verified snapshot

The current release covers macOS Sonoma 14.8.3 arm64 with the default `/opt/homebrew` prefix:

| Formula | Version | Managed runtime dependencies |
| --- | --- | --- |
| `sqlite` | 3.53.4 | `xiaoran007/bottles/readline` |
| `readline` | 8.3.6 | None |
| `zstd` | 1.5.7_1 | `xiaoran007/bottles/lz4`, `xiaoran007/bottles/xz` |
| `lz4` | 1.10.0 | None |
| `xz` | 5.8.4 | None |

Each root was installed from a request for only its fully qualified tap formula in a clean Sonoma arm64 Tart VM. Homebrew automatically selected and poured the listed dependencies from this tap and public GHCR. All five formulae passed linkage checks and upstream formula tests. See [`registry/v1/catalog.json`](registry/v1/catalog.json) for exact upstream formula identities, bottle hashes, OCI digests, and verification summaries.

## Install

If you trust this entire tap, including future formulae, casks, and commands:

```sh
brew tap xiaoran007/bottles
brew trust --tap xiaoran007/bottles
brew install --force-bottle xiaoran007/bottles/sqlite
brew install --force-bottle xiaoran007/bottles/zstd
```

To limit trust to one verified dependency closure, use `brew trust --formula` for its root and every listed managed dependency instead of `brew trust --tap`. For example, SQLite needs both `readline` and `sqlite`; zstd needs `lz4`, `xz`, and `zstd`. A fully qualified root request alone does not trust its dependencies. See [Homebrew Tap Trust](https://docs.brew.sh/Tap-Trust).

These formulae record Homebrew Core source identities at publication time. If Core changes later, they are no longer an exact match for the newer Core formulae. Existing installations of same-name Core formulae are not automatically migrated. Other macOS releases, architectures, and prefixes have not been verified by this project.

## Provenance and license

The derived formulae retain upstream source and build logic. Distribution metadata and managed dependency sources are changed, and Core-only `no_autobump!` maintenance declarations are removed with the original text recorded in the [source project's derivation evidence](https://github.com/xiaoran007/LegacyBrew). Homebrew Core formulae are distributed under the BSD 2-Clause License; see [`LICENSE-CORE.txt`](LICENSE-CORE.txt).
