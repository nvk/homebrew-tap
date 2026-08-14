# Releasing

This tap currently publishes:

- `ascii-banner`
- `agentnoise`
- `agent-bondage`
- `envchain-xtra`
- `webdownloader`
- `edpdf`

The `agentnoise` formula tracks releases from:

- `https://github.com/nvk/agentnoise`

The `agent-bondage` formula tracks releases from:

- `https://github.com/nvk/bondage`

The `envchain-xtra` formula tracks releases from:

- `https://github.com/nvk/envchain-xtra`

The `webdownloader` formula tracks releases from:

- `https://github.com/nvk/webdownloader`

The `edpdf` formula tracks releases from:

- `https://github.com/nvk/edpdf`

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

For `webdownloader`:

1. Release/tag the desired `webdownloader` commit.
2. Update `Formula/webdownloader.rb`:
   - `url` tag
   - `sha256`
   - Python resources when dependencies change
3. Commit the tap change on `main`.
4. Push `main`.
5. Verify install from Homebrew.

For `edpdf`:

1. Release/tag the desired `edpdf` commit.
2. Update `Formula/edpdf.rb`:
   - `url` tag
   - `sha256`
3. Update the packaged version in `README.md`.
4. Commit and push the tap change on `main`.
5. Verify with `brew install nvk/tap/edpdf` and `brew test nvk/tap/edpdf`.

## Example

```zsh
TAP_DIR=/path/to/homebrew-tap
git -C "$TAP_DIR" pull --ff-only origin main
```

Edit:

- `Formula/agent-bondage.rb`
- `Formula/agentnoise.rb`
- `Formula/envchain-xtra.rb`
- `Formula/webdownloader.rb`

Then:

```zsh
git -C "$TAP_DIR" add Formula/agent-bondage.rb Formula/agentnoise.rb Formula/edpdf.rb README.md RELEASING.md
git -C "$TAP_DIR" commit -m 'agent-bondage 0.2.0'
git -C "$TAP_DIR" push origin main
```

## Verify

```zsh
brew update
brew install nvk/tap/agentnoise
brew install nvk/tap/agent-bondage
brew install nvk/tap/envchain-xtra
brew install nvk/tap/webdownloader
brew install nvk/tap/edpdf
```

If a previous upstream `envchain` install exists:

```zsh
brew uninstall envchain
brew install nvk/tap/envchain-xtra
brew install nvk/tap/webdownloader
```
