# Releasing

This tap currently publishes:

- `ascii-banner`
- `envchain-xtra`

The `envchain-xtra` formula tracks releases from:

- `https://github.com/nvk/envchain-xtra`

## Update Flow

1. Release/tag the desired `envchain-xtra` commit.
2. Update `Formula/envchain-xtra.rb`:
   - `tag`
   - `revision`
   - `version`
3. Commit the tap change on `main`.
4. Push `main`.
5. Verify install from Homebrew.

## Example

```zsh
git -C "$HOME/Library/Mobile Documents/com~apple~CloudDocs/claude-sandbox/homebrew-tap" pull --ff-only origin main
```

Edit:

- `Formula/envchain-xtra.rb`

Then:

```zsh
git -C "$HOME/Library/Mobile Documents/com~apple~CloudDocs/claude-sandbox/homebrew-tap" add Formula/envchain-xtra.rb README.md RELEASING.md
git -C "$HOME/Library/Mobile Documents/com~apple~CloudDocs/claude-sandbox/homebrew-tap" commit -m 'envchain-xtra 1.2.1'
git -C "$HOME/Library/Mobile Documents/com~apple~CloudDocs/claude-sandbox/homebrew-tap" push origin main
```

## Verify

```zsh
brew update
brew install nvk/tap/envchain-xtra
```

If a previous upstream `envchain` install exists:

```zsh
brew uninstall envchain
brew install nvk/tap/envchain-xtra
```
