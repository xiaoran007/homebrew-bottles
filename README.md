# LegacyBrew bottles

This Homebrew tap distributes verified bottles for selected formulae on older macOS releases. Formulae are derived from current Homebrew Core sources; Homebrew still resolves dependencies and performs installation.

## Published packages

[`registry/v2/catalog.json`](registry/v2/catalog.json) is the current availability snapshot. Packages are peers in one dependency graph. Each package record identifies its supported environment, current Core formula source, bottle, GHCR image, and verified runtime dependencies. A package is advertised only after its complete managed runtime closure passes an independent installation from this tap and public GHCR.

The registry describes the published snapshot, not every package in the private build catalog. Availability can change as Core formulae change; a published bottle is an exact match only while the current official formula identity still matches its record.

## Install

To trust this entire tap, including future additions:

```sh
brew tap xiaoran007/bottles
brew trust --tap xiaoran007/bottles
brew install --force-bottle xiaoran007/bottles/FORMULA
```

Replace `FORMULA` with a package in the registry. Fully qualified tap names keep managed runtime dependencies on this tap. To limit trust, use `brew trust --formula` for the requested package and every managed package in its runtime closure instead. Existing same-name Homebrew Core installations are not automatically migrated.

## Provenance and license

The derived formulae retain upstream sources and build logic. Distribution metadata and managed dependency sources are changed, and Core-only `no_autobump!` maintenance declarations are removed with the original text recorded in the [LegacyBrew source repository](https://github.com/xiaoran007/LegacyBrew). Homebrew Core formulae are distributed under the BSD 2-Clause License; see [`LICENSE-CORE.txt`](LICENSE-CORE.txt).
