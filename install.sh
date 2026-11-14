#!/usr/bin/env bash
# Installer for the otype/emacs.d Emacs configuration.
#
#   curl -fsSL https://raw.githubusercontent.com/otype/emacs.d/main/install.sh | bash
#
# Safe to run again: it updates an existing clone instead of replacing it.
# See --help for options.
set -euo pipefail

REPO_URL="${EMACS_D_REPO:-https://github.com/otype/emacs.d.git}"
DEST="${EMACS_D_DIR:-$HOME/.emacs.d}"
MIN_EMACS_MAJOR=30 # `use-package' :vc, used for claude-code-ide
TS="$(date +%Y%m%d-%H%M%S)"

CHECK=0
PACKAGES=1
NAME=""
EMAIL=""

usage() {
  cat <<EOF
Usage: install.sh [options]

Clone (or update) the configuration into $DEST and install all Emacs packages.

Options:
  --check          Report what would change, change nothing. Exit 1 if
                   anything would change.
  --no-packages    Skip the headless package installation; packages are then
                   installed on the first start of Emacs.
  --name NAME      Value for user-full-name in elisp/user.el
  --email EMAIL    Value for user-mail-address in elisp/user.el
  -h, --help       Show this help

Without --name/--email, a fresh clone takes both from \`git config\`.

Environment:
  EMACS_D_DIR      Install location (default: ~/.emacs.d)
  EMACS_D_REPO     Repository to clone (default: $REPO_URL)
EOF
}

say() { printf '%s\n' "$*"; }
warn() { printf 'WARN  %s\n' "$*" >&2; }
die() { printf 'ERROR %s\n' "$*" >&2; exit 1; }

while [ $# -gt 0 ]; do
  case "$1" in
    --check) CHECK=1 ;;
    --no-packages) PACKAGES=0 ;;
    --name) [ $# -ge 2 ] || die "--name needs a value"; NAME="$2"; shift ;;
    --email) [ $# -ge 2 ] || die "--email needs a value"; EMAIL="$2"; shift ;;
    -h | --help) usage; exit 0 ;;
    *) usage >&2; die "unknown option: $1" ;;
  esac
  shift
done

DRIFT=0
changed() { DRIFT=1; }

# --- preflight ---------------------------------------------------------------

command -v git >/dev/null 2>&1 || die "git is required"
command -v emacs >/dev/null 2>&1 || die "emacs is required (version $MIN_EMACS_MAJOR or newer)"

emacs_major="$(emacs --version | sed -n '1s/[^0-9]*\([0-9][0-9]*\).*/\1/p')"
if [ -z "$emacs_major" ] || [ "$emacs_major" -lt "$MIN_EMACS_MAJOR" ]; then
  die "Emacs $MIN_EMACS_MAJOR or newer is required, found: $(emacs --version | head -n1)"
fi
say "OK    $(emacs --version | head -n1)"

# Optional pieces: warn only, never install system packages.
command -v ag >/dev/null 2>&1 || warn "ag (The Silver Searcher) not found; helm-projectile-ag will not work"
if command -v fc-list >/dev/null 2>&1; then
  # Capture first: `fc-list | grep -q' would die of SIGPIPE under pipefail.
  fonts="$(fc-list 2>/dev/null || true)"
  grep -qi 'liberation mono' <<<"$fonts" || warn "font 'Liberation Mono' not found; Emacs will fall back to another font"
  grep -qi 'nerd font' <<<"$fonts" || warn "no Nerd Font found; icons may show as boxes (run M-x nerd-icons-install-fonts in Emacs)"
fi
for server in gopls rust-analyzer pyright; do
  command -v "$server" >/dev/null 2>&1 || warn "language server '$server' not found (needed only if you use that language layer)"
done
command -v black >/dev/null 2>&1 || warn "'black' not found; Python format-on-save will not work"
command -v prettier >/dev/null 2>&1 || warn "'prettier' not found; JavaScript/HTML format-on-save will not work"
if [ "$DEST" = "$HOME/.emacs.d" ] && [ -e "$HOME/.emacs" ]; then
  warn "$HOME/.emacs exists and takes precedence over $DEST/init.el; move it away"
fi

# --- clone or update ---------------------------------------------------------

FRESH=0
if [ -d "$DEST/.git" ]; then
  origin="$(git -C "$DEST" remote get-url origin 2>/dev/null || true)"
  case "$origin" in
    *otype/emacs.d* | "$REPO_URL") ;;
    *) die "$DEST is a git repository for '$origin', not this configuration; move it away first" ;;
  esac
  # elisp/user.el is expected to differ: the installer writes the identity there.
  if [ -n "$(git -C "$DEST" status --porcelain -- . ':!elisp/user.el')" ]; then
    warn "$DEST has uncommitted changes; leaving the checkout as it is"
  else
    git -C "$DEST" fetch --quiet origin </dev/null
    behind="$(git -C "$DEST" rev-list --count 'HEAD..@{u}' 2>/dev/null || echo 0)"
    if [ "$behind" -gt 0 ]; then
      changed
      if [ "$CHECK" -eq 1 ]; then
        say "DRIFT $DEST is $behind commit(s) behind origin"
      else
        # Fetched above; merge instead of `pull' so a global pull.rebase
        # setting cannot trip over the modified elisp/user.el.
        git -C "$DEST" merge --ff-only --quiet '@{u}' </dev/null
        say "UPDATE $DEST ($behind new commit(s))"
      fi
    else
      say "OK    $DEST is up to date"
    fi
  fi
else
  changed
  if [ "$CHECK" -eq 1 ]; then
    if [ -e "$DEST" ]; then
      say "DRIFT $DEST exists and would be moved to $DEST.bak-$TS, then cloned"
    else
      say "DRIFT $DEST is missing and would be cloned from $REPO_URL"
    fi
  else
    if [ -e "$DEST" ] || [ -L "$DEST" ]; then
      mv "$DEST" "$DEST.bak-$TS"
      say "BACKUP $DEST -> $DEST.bak-$TS"
    fi
    git clone --quiet "$REPO_URL" "$DEST" </dev/null
    say "CLONE $REPO_URL -> $DEST"
    FRESH=1
  fi
fi

# --- identity ----------------------------------------------------------------

# Escape a value for an Emacs Lisp string, then for a sed replacement.
elisp_escape() {
  printf '%s' "$1" | sed -e 's/[\\"]/\\&/g' | sed -e 's/[\\&|]/\\&/g'
}

if [ "$FRESH" -eq 1 ] || [ -n "$NAME" ] || [ -n "$EMAIL" ]; then
  if [ "$CHECK" -eq 0 ] && [ -f "$DEST/elisp/user.el" ]; then
    [ -n "$NAME" ] || NAME="$(git config --global user.name 2>/dev/null || true)"
    [ -n "$EMAIL" ] || EMAIL="$(git config --global user.email 2>/dev/null || true)"
    if [ -n "$NAME" ]; then
      sed -i -e "s|\\(user-full-name[[:space:]]*\\)\"[^\"]*\"|\\1\"$(elisp_escape "$NAME")\"|" "$DEST/elisp/user.el"
      say "SET   user-full-name in elisp/user.el"
    else
      warn "no name known; edit user-full-name in $DEST/elisp/user.el"
    fi
    if [ -n "$EMAIL" ]; then
      sed -i -e "s|\\(user-mail-address[[:space:]]*\\)\"[^\"]*\"|\\1\"$(elisp_escape "$EMAIL")\"|" "$DEST/elisp/user.el"
      say "SET   user-mail-address in elisp/user.el"
    else
      warn "no email known; edit user-mail-address in $DEST/elisp/user.el"
    fi
  fi
fi

# --- packages ----------------------------------------------------------------

if [ "$PACKAGES" -eq 1 ] && [ "$CHECK" -eq 0 ] && [ -f "$DEST/init.el" ]; then
  say "Installing Emacs packages (first run takes a few minutes)..."
  if emacs --batch --init-directory "$DEST" -l "$DEST/init.el" </dev/null; then
    say "OK    packages installed"
  else
    die "package installation failed; start Emacs once to see the errors, or re-run this script"
  fi
fi

# --- result ------------------------------------------------------------------

if [ "$CHECK" -eq 1 ]; then
  if [ "$DRIFT" -eq 1 ]; then
    say "Not up to date; run without --check to apply."
    exit 1
  fi
  say "Nothing to do."
  exit 0
fi

cat <<EOF

Done. Next steps:
  - Enable more languages by uncommenting the (require 'lang-...) lines in
    $DEST/init.el.
  - Start Emacs: emacs
EOF
