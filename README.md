# Nvk Tap

## Formulae

- `ascii-banner`
- `agent-bondage`
- `envchain-xtra`

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

## Documentation

`brew help`, `man brew` or check [Homebrew's documentation](https://docs.brew.sh).

For tap maintenance and release steps, see
[`RELEASING.md`](RELEASING.md).
