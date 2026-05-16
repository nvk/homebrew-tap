# Nvk Tap

This tap carries a small stack for running coding agents with a narrower trust
boundary:

- `envchain-xtra` for secret release from Keychain-backed namespaces
- `agent-bondage` for exact launch verification and policy
- `agentnoise` for controlling local Codex/Claude sessions through White Noise

The premise is that agents should not run loose with live keys, weak dependency
provenance, and broad ambient environment access.

`agentnoise` exists because the available agent-chat bridges were too heavy,
too slow-moving, or too awkward for a simple native White Noise to local-agent
bridge.

The less polite design brief: I had to build it because everything else sucks
and Jeff moves too slow.

## Formulae

- `ascii-banner`
- `agentnoise`
- `agent-bondage`
- `envchain-xtra`
- `whodis`

## How do I install these formulae?

`brew install nvk/tap/<formula>`

Or `brew tap nvk/tap` and then `brew install <formula>`.

Or, in a `brew bundle` `Brewfile`:

```ruby
tap "nvk/tap"
brew "<formula>"
```

### `envchain-xtra`

`envchain-xtra` installs the `envchain` executable and intentionally conflicts
with the upstream Homebrew `envchain` formula, because both install the same
binary name.

Install it with:

```zsh
brew install nvk/tap/envchain-xtra
```

If upstream `envchain` is already installed:

```zsh
brew uninstall envchain
brew install nvk/tap/envchain-xtra
```

### `agent-bondage`

`agent-bondage` installs the `bondage` executable.

Install it with:

```zsh
brew install nvk/tap/agent-bondage
```

### `agentnoise`

`agentnoise` installs the native desktop helper plus the upstream White Noise
`wn` and `wnd` binaries.

Install it with:

```zsh
brew install nvk/tap/agentnoise
```

Then run first setup:

```zsh
agentnoise up
```

### `whodis`

`whodis` installs an RDAP-first domain intelligence CLI.

Install it with:

```zsh
brew install nvk/tap/whodis
```

## Documentation

`brew help`, `man brew` or check [Homebrew's documentation](https://docs.brew.sh).

For tap maintenance and release steps, see
[`RELEASING.md`](RELEASING.md).

## License

MIT License. Copyright (c) 2026 nvk.

This software is provided as-is, without warranty of any kind.
