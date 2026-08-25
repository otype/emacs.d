# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

A personal Emacs configuration (loaded from `~/.emacs.d`), built on `use-package`, `helm`, `projectile`, `flycheck`, and `smartparens`. There is no build/test/lint tooling — changes are validated by loading the config in Emacs and checking for errors/warnings, not by a CI pipeline.

## Reloading and validating changes

- Reload the running config: `M-x my-reload-emacs-configuration` (bound to `C-c <f12>`), defined in `elisp/base-functions.el`. Re-evaluates `init.el` in place.
- Full validation: quit and restart Emacs (`emacs`) so `package.el`/`use-package` re-run from a clean state — required to catch load-order or first-install issues that a live reload won't surface.
- There is no batch/headless byte-compile or lint step in this repo; watch the `*Messages*` and `*Warnings*` buffers after reload/restart for `use-package` failures.

## Architecture

**Load order is defined in `init.el`** and is significant — later files assume earlier ones are loaded:

1. `elisp/user.el` — personal identity (name/email), loaded first.
2. Base layers, in order: `base` → `base-theme` → `base-extensions`.
   - `elisp/base.el`: package.el/MELPA bootstrap, `use-package` bootstrap, core Emacs settings (encoding, backups, `savehist`, `custom-file` location). Everything else depends on `use-package` being available after this loads.
   - `elisp/base-theme.el`: UI/theming packages (`modus-themes`, `doom-modeline`, `centaur-tabs`, `all-the-icons`) and frame-level settings (font, fringe, line numbers).
   - `elisp/base-extensions.el`: the bulk of the config — every non-language `use-package` block (helm, projectile, magit, lsp-mode, org, org-roam, etc.) lives here in one file, alphabetized by package name.
3. `elisp/base-functions.el` / `elisp/base-global-keys.el` — custom interactive functions and global keybindings, loaded after extensions so they can reference packages like `org-roam`.
4. Language layers (`elisp/lang-*.el`) — one file per language, each self-contained (`use-package` blocks + a trailing `(provide 'lang-x)`). Commented-out `require` lines in `init.el` mark language layers that exist but are disabled (currently Haskell, Java, Ruby, Vala).

**Key architectural pattern: unified LSP backend.** All active language layers (Elixir, Go, JavaScript, Lisp, Python, Rust, Terraform) hook into the single `lsp-mode` instance configured in `base-extensions.el`, using `company` as the shared completion frontend. Language files add language-specific `lsp-mode` settings (e.g. `lsp-rust-analyzer-*` variables in `lang-rust.el`) rather than configuring a separate LSP client per language. Python is the one exception, using `lsp-pyright` directly instead of routing through generic `lsp-mode` package selection.

**Formatting on save is per-language and opt-in via hooks**, not centralized: `lang-rust.el` sets `rustic-format-on-save`, `lang-go.el` hooks `gofmt-before-save` onto `before-save-hook` (buffer-locally, Go files only), `lang-python.el` uses `blacken-mode`. There's also a global `delete-trailing-whitespace` on `before-save-hook` in `base.el` that applies to every buffer.

**Package installation**: `use-package-always-ensure` is `t` (set in `base.el`), so any new `use-package` block auto-installs from MELPA on next load — no separate install step needed. Two packages (`claude-code-ide`, `copilot`) are pinned via `package-vc` in `.custom.el` rather than MELPA, since they track upstream git directly.

**`.custom.el`** is the `custom-file` target (set in `base.el`) — Emacs' own `customize` UI writes here, not to `init.el`. Don't hand-edit `custom-set-variables`/`custom-set-faces` blocks unless necessary; prefer the `use-package` `:custom` keyword in the relevant `elisp/*.el` file for new settings so they stay documented alongside the package they configure.

**`private/`** holds machine/host-specific cache and data (recentf, bookmarks, projectile cache) via `temp-dir` in `base.el` — not meant to be edited directly, and is gitignored.

## Adding a new package or language

- Non-language package: add a `use-package` block to `elisp/base-extensions.el`, keeping alphabetical order among existing blocks, with a one/two-line comment above it describing what it does and a link to its repo (matches the existing style throughout that file).
- New language: create `elisp/lang-<name>.el` following the pattern in existing `lang-*.el` files (package `use-package` blocks + language-specific `lsp-mode` `:custom` overrides if needed + `(provide 'lang-<name>)`), then add `(require 'lang-<name>)` to `init.el` in alphabetical order among the language layers.
- Custom interactive functions go in `elisp/base-functions.el`; global keybindings go in `elisp/base-global-keys.el` (both loaded after `base-extensions`, so they may reference any package configured there).

## Workflow

- Always submit changes via a pull request (branch + `gh pr create`), never commit or push directly to `main`, unless the user explicitly says to merge/push straight to `main` for that specific change.
- Use `/home/hgschmidt/.claude/skills/pr-description/scripts/create-pr.sh` to open the PR (branch, commit, push, `gh pr create` in one step) rather than chaining separate `git`/`gh` calls — it refuses to run on the default branch without an explicit `--branch`.

## Keybinding prefixes

Established `C-c` prefix conventions to follow when adding new bindings (full reference in `README.md`):
- `C-c h` — Helm
- `C-c l` — LSP (bound under `lsp-mode-map`)
- `C-c m` — Magit
- `C-c o` — Org
- `C-c p` — Projectile (`projectile-command-map`)
- `C-c r` — Org-roam
