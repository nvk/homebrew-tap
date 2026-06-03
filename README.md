# nvk/homebrew-tap

Homebrew tap for NVK's small local-agent toolchain and a few utility CLIs.

The main stack here is for running coding agents with fewer ambient privileges:

- [`agent-bondage`](https://agentbondage.org/) installs `bondage`, a small C
  launcher that verifies exact targets, interpreters, hashes, and profile policy
  before exec.
- [`envchain-xtra`](https://github.com/nvk/envchain-xtra) installs `envchain`, a
  Keychain-backed secret-release helper with macOS-focused fixes.
- [`agentnoise`](https://agentnoise.org/) installs a native White Noise control
  plane for launching local Codex, Claude, Hermes, and wiki jobs from a phone.

The premise is simple: coding agents should not run loose with live keys, weak
package provenance, and broad filesystem access just because they came from a
friendly shell alias.

## Quick install

Install one package directly:

```sh
brew install nvk/tap/agent-bondage
brew install nvk/tap/agentnoise
brew install --cask nvk/tap/qrme
```

Or tap once and install by short name:

```sh
brew tap nvk/tap
brew install agent-bondage agentnoise whodis webdownloader
brew install --cask qrme
```

In a `Brewfile`:

```ruby
tap "nvk/tap"
brew "agent-bondage"
brew "envchain-xtra"
brew "agentnoise"
brew "webdownloader"
cask "qrme"
```

## Packages

| Formula / cask | Installed command | Current packaged version | What it is |
| --- | --- | --- | --- |
| `agent-bondage` | `bondage` | `0.2.7` | Exact launch verification and policy boundary for local agent profiles. |
| `touchid-check` | `touchid-check` | `0.2.7` | Optional macOS Touch ID/password approval helper for `bondage` profiles. |
| `envchain-xtra` | `envchain` | `1.3.1` | Keychain-backed environment launcher; conflicts with upstream `envchain`. |
| `agentnoise` | `agentnoise`, `wn`, `wnd` | `0.1.35` | Stable White Noise mainline control plane for local coding agents. |
| `agentnoise-darkmatter` | `agentnoise-dm` | `0.2.0-alpha.10` | Experimental Dark Matter/Marmot v2 build, isolated from stable `agentnoise`. |
| `whodis` | `whodis` | `0.3.0` | RDAP-first domain intelligence CLI. |
| `webdownloader` | `webdownloader` | `1.0.2` | Save same-domain web pages for offline use. |
| `ascii-banner` | `ascii-banner` | `0.6.0` | Text-to-ASCII banner generator using FIGlet fonts. |
| `qrme` cask | macOS Service | `0.1.0` | Show selected text as a QR code from the macOS Services menu. |

## Local agent stack

The recommended hardening path is:

```text
shell alias -> bondage -> [envchain-xtra] -> [nono] -> exact pinned tool
```

Install the Homebrew pieces:

```sh
brew tap nvk/tap
brew install nvk/tap/agent-bondage
brew install nvk/tap/envchain-xtra   # optional, only for explicit secret release
brew install nono                    # upstream sandbox layer
```

Useful references:

- Stack guide: <https://learntoprompt.org/guides/agent-stack.html>
- Bondage site: <https://agentbondage.org/>
- Public starter templates: <https://github.com/nvk/agent-stack-bootstrap>

After upgrades, re-pin and verify your local launcher config instead of silently
trusting changed binaries:

```sh
export BONDAGE_CONF="${BONDAGE_CONF:-$HOME/.config/bondage/bondage.conf}"

bondage --config "$BONDAGE_CONF" repin-globals
bondage --config "$BONDAGE_CONF" doctor
bondage --config "$BONDAGE_CONF" verify codex
bondage --config "$BONDAGE_CONF" chain codex -- --help
```

## AgentNoise

Stable `agentnoise` is the White Noise mainline path. Homebrew installs the
native helper plus the upstream White Noise `wn` and `wnd` binaries.

Simple direct-agent setup, without `bondage` profiles:

```sh
brew install nvk/tap/agentnoise
agentnoise up --direct-agents --no-listen
brew services start nvk/tap/agentnoise
agentnoise worker start --tmux
```

Homebrew keeps the White Noise transport alive. The worker runs Codex, Claude,
Hermes, and wiki jobs from your login shell so those tools see the same local
session and permissions you use manually. If you already maintain hardened
profiles, omit `--direct-agents` and provide `codex-agentnoise` /
`claude-agentnoise` profiles.

Experimental Dark Matter/Marmot v2 builds are separate:

```sh
brew install nvk/tap/agentnoise-darkmatter
agentnoise-dm up --direct-agents
brew services start nvk/tap/agentnoise-darkmatter
agentnoise-dm worker start --tmux
```

`agentnoise-dm` uses a separate config/data/log/keychain namespace, service
label, and phone pairing. Do not pair it to your main identity unless you are
explicitly testing the Dark Matter migration.

More: <https://agentnoise.org/> and
<https://learntoprompt.org/guides/agentnoise.html>.

## Utility installs

```sh
brew install nvk/tap/whodis
brew install nvk/tap/webdownloader
brew install nvk/tap/ascii-banner
brew install --cask nvk/tap/qrme
```

`envchain-xtra` installs the same binary name as upstream `envchain`. If the
upstream formula is already installed, remove it first:

```sh
brew uninstall envchain
brew install nvk/tap/envchain-xtra
```

## Maintenance

For formula release and repinning steps, see [`RELEASING.md`](RELEASING.md).
Common checks while editing the tap:

```sh
brew audit --strict nvk/tap/agent-bondage
brew test nvk/tap/agent-bondage
brew readall nvk/tap
```

## License

MIT License. Copyright (c) 2026 nvk.

This software is provided as-is, without warranty of any kind.
