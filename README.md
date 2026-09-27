# LegacyBrew bottles

This is the public **distribution repository** for [LegacyBrew](https://github.com/xiaoran007/LegacyBrew). It contains the `xiaoran007/bottles` Homebrew tap: generated formulae in [`Formula/`](Formula/) and the published package registry in [`registry/v1/catalog.json`](registry/v1/catalog.json). Bottle archives are served from public GHCR. Development, build orchestration, and issue tracking belong in the LegacyBrew source repository.

## Availability

The current public snapshot contains five formulae: `sqlite`, `readline`, `zstd`, `lz4`, and `xz`. See the registry for their exact versions, bottle hashes, and dependency records.

The registry is the published availability snapshot. It records each package's supported environment, upstream formula identity, bottle, and verified managed dependencies. Only packages whose complete managed runtime closure passed installation from the candidate tap and public GHCR are advertised. A package in LegacyBrew's private build catalog is not necessarily published here.

The current publishing profile is macOS Sonoma 14.8.3 arm64 with Homebrew at `/opt/homebrew`. Other systems are not verified. Homebrew Core formulae can change after publication; the registry's recorded identity must match the formula currently selected by Homebrew for the bottle to be an exact current-Core match. Direct `brew install` from this tap does not make that comparison for you. The `lbrew` client performs it, but is not yet packaged for users.

## Install

Review the [registry](registry/v1/catalog.json) and choose a published formula. To trust this entire tap, including all current and future formulae, casks, and external commands:

```sh
brew tap xiaoran007/bottles
brew trust --tap xiaoran007/bottles
brew install --force-bottle xiaoran007/bottles/FORMULA
```

Replace `FORMULA` with the formula name. A fully qualified name selects this tap; generated formulae name their managed dependencies from this tap as well. For narrower trust, use `brew trust --formula` for the requested formula and every managed package in its dependency closure instead of trusting the entire tap. See [Homebrew Tap Trust](https://docs.brew.sh/Tap-Trust). Existing same-name Homebrew Core installations are not automatically migrated.

## Project statement and support

LegacyBrew is independent of Homebrew and its team. It is not affiliated with, endorsed by, or a subproject of Homebrew. Decide for yourself whether to install these bottles. They are provided **as is**, without warranty, and at your own risk. The LegacyBrew maintainers accept no liability for loss or damage arising from their use, to the extent permitted by applicable law. See the [source license](https://github.com/xiaoran007/LegacyBrew/blob/main/LICENSE) and each package's upstream license.

**Report any issue involving this tap, its formulae, bottles, registry, or LegacyBrew to the [LegacyBrew issue tracker](https://github.com/xiaoran007/LegacyBrew/issues). Do not report LegacyBrew-related issues to Homebrew.**

## Provenance

Derived formulae retain upstream sources and build logic. Publication changes bottle metadata and managed dependency sources; Core-only `no_autobump!` maintenance declarations may be removed with their original text recorded in the [source project](https://github.com/xiaoran007/LegacyBrew). Homebrew Core formulae are distributed under the BSD 2-Clause License; see [`LICENSE-CORE.txt`](LICENSE-CORE.txt).
