# Releasing

This tap currently publishes:

- `ascii-banner`
- `agentnoise`
- `agent-bondage`
- `envchain-xtra`

The `agentnoise` formula tracks releases from:

- `https://github.com/nvk/agentnoise`

The `agent-bondage` formula tracks releases from:

- `https://github.com/nvk/bondage`

The `envchain-xtra` formula tracks releases from:

- `https://github.com/nvk/envchain-xtra`

## Update Flow

For `agent-bondage`:

1. Release/tag the desired `bondage` commit.
2. Update `Formula/agent-bondage.rb`:
   - `tag`
   - `revision`
   - `version`
3. Commit the tap change on `main`.
4. Push `main`.
5. Verify install from Homebrew.

For `agentnoise`:

1. Release/tag the desired `agentnoise` commit.
2. Update `Formula/agentnoise.rb`:
   - `tag`
   - `revision`
   - `version`
   - bundled `whitenoise-rs` `revision` when upgrading White Noise
3. Commit the tap change on `main`.
4. Push `main`.
5. Verify install from Homebrew.

For `envchain-xtra`:

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
TAP_DIR=/path/to/homebrew-tap
git -C "$TAP_DIR" pull --ff-only origin main
```

Edit:

- `Formula/agent-bondage.rb`
- `Formula/agentnoise.rb`
- `Formula/envchain-xtra.rb`

Then:

```zsh
git -C "$TAP_DIR" add Formula/agent-bondage.rb Formula/agentnoise.rb README.md RELEASING.md
git -C "$TAP_DIR" commit -m 'agent-bondage 0.2.0'
git -C "$TAP_DIR" push origin main
```

## Verify

```zsh
brew update
brew install nvk/tap/agentnoise
brew install nvk/tap/agent-bondage
brew install nvk/tap/envchain-xtra
```

If a previous upstream `envchain` install exists:

```zsh
brew uninstall envchain
brew install nvk/tap/envchain-xtra
```
