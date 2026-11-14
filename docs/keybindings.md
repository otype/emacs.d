# 🔑 Key bindings reference

Every binding set by this configuration, grouped by prefix. The source of truth
is the code; if you add a binding, add it here too.

- **Global** bindings work in every buffer.
- Bindings marked *(mode)* only exist in buffers of that mode.

Conventions for new bindings are in [`CLAUDE.md`](../CLAUDE.md#keybinding-prefixes).

## 🌍 Global

| Binding | Command | Defined in |
|---|---|---|
| `C-c d` | `duplicate-current-line-or-region` (whole lines, repeat with a prefix arg) | `base-global-keys.el` |
| `C-c <f12>` | `my-reload-emacs-configuration` | `base-global-keys.el` |
| `C-z`, `C-x C-z` | *unbound*, so Emacs is never suspended by accident | `base-global-keys.el` |
| `C-=` | `er/expand-region` | `base-extensions.el` |
| `C-s-;` | `iedit-mode` (edit all occurrences) | `base-extensions.el` |
| `C-a`, `<home>` | `mwim-beginning` (smart beginning of line/code/comment) | `base-extensions.el` |
| `C-e`, `<end>` | `mwim-end` | `base-extensions.el` |
| `C-<prior>` | `centaur-tabs-backward` | `base-theme.el` |
| `C-<next>` | `centaur-tabs-forward` | `base-theme.el` |
| `C-c c` | `claude-code-ide-menu` | `base-extensions.el` |
| `C-c p …` | `projectile-command-map` (all Projectile commands) | `base-extensions.el` |

## 🧭 Helm (`C-c h …`)

`C-c h` is `helm-command-prefix`, so Helm's own `helm-command-map` is available
under it in addition to the bindings below.

| Binding | Command |
|---|---|
| `M-x` | `helm-M-x` |
| `C-x C-f` | `helm-find-files` |
| `C-x b` | `helm-mini` (buffer switcher) |
| `M-y` | `helm-show-kill-ring` |
| `C-c h a` | `helm-projectile-ag` |
| `C-c h b` | `helm-filtered-bookmarks` |
| `C-c h d` | `helm-do-ag` |
| `C-c h g` | `helm-browse-project` |
| `C-c h i` | `helm-semantic-or-imenu` |
| `C-c h k` | `helm-show-kill-ring` |
| `C-c h m` | `helm-mini` |
| `C-c h o` | `helm-occur` |
| `C-c h r` | `helm-resume` |
| `C-c h v` | `helm-projectile` |

Inside a Helm session:

| Binding | Command |
|---|---|
| `<tab>`, `C-z` | `helm-execute-persistent-action` |

## 🧠 LSP (`C-c l …`) *(lsp-mode buffers)*

| Binding | Command |
|---|---|
| `C-c l r` | `lsp-rename` |
| `C-c l a` | `lsp-execute-code-action` |
| `C-c l f` | `lsp-format-buffer` |
| `C-c l d` | `lsp-describe-thing-at-point` |
| `C-c l l` | `lsp-ui-flycheck-list` |

## 🌿 Magit (`C-c m …`)

| Binding | Command |
|---|---|
| `C-c m b` | `magit-branch-and-checkout` |
| `C-c m c` | `magit-commit` |
| `C-c m d` | `magit-diff-unstaged` |
| `C-c m e` | `magit-ediff-resolve` |
| `C-c m f` | `magit-fetch` |
| `C-c m l` | `magit-log-current` |
| `C-c m p` | `magit-push` |
| `C-c m r` | `magit-rebase-interactive` |
| `C-c m s` | `magit-status` |
| `C-c m u` | `magit-pull` |
| `C-c m x` | `magit-checkout` |

## 📝 Org (`C-c o …`)

| Binding | Command |
|---|---|
| `C-c o a` | `org-agenda` |
| `C-c o c` | `org-capture` |
| `C-c o s` | `org-store-link` |

## 🕸️ Org-roam (`C-c r …`)

Global:

| Binding | Command |
|---|---|
| `C-c r f` | `org-roam-node-find` |
| `C-c r g` | `org-roam-graph` |
| `C-c r l` | `org-roam-buffer-toggle` |
| `C-c r r` | `org-roam-node-random` |

In Org buffers *(org-mode)*:

| Binding | Command |
|---|---|
| `C-c r a` | `org-roam-alias-add` |
| `C-c r c` | `completion-at-point` |
| `C-c r d` | `org-roam-dailies-capture-today` |
| `C-c r e` | `org-roam-capture` |
| `C-c r i` | `org-roam-node-insert` |
| `C-c r o` | `org-id-get-create` |
| `C-c r t` | `org-roam-tag-add` |

## 💻 Languages

### 🐹 Go *(go-mode)*

| Binding | Command |
|---|---|
| `C-c C-r` | `go-remove-unused-imports` |
| `C-c C-g` | `go-goto-imports` |

### 🦀 Rust *(rustic-mode)*

| Binding | Command |
|---|---|
| `M-j` | `lsp-ui-imenu` |
| `M-?` | `lsp-find-references` |
| `C-c C-r l` | `flycheck-list-errors` |
| `C-c C-r a` | `lsp-execute-code-action` |
| `C-c C-r r` | `lsp-rename` |
| `C-c C-r q` | `lsp-workspace-restart` |
| `C-c C-r Q` | `lsp-workspace-shutdown` |
| `C-c C-r s` | `lsp-rust-analyzer-status` |

### 📄 YAML *(yaml-mode)*

| Binding | Command |
|---|---|
| `RET` | `newline-and-indent` |
