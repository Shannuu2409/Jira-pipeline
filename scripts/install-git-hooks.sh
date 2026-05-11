#!/usr/bin/env bash
# =============================================================================
#  install-git-hooks.sh
# -----------------------------------------------------------------------------
#  One-time setup: point this clone's git hooks at the versioned hooks
#  directory under `scripts/git-hooks/` so every developer gets the same
#  Jira-ID enforcement on `git commit`.
#
#  USAGE
#  -----
#       bash scripts/install-git-hooks.sh
#
#  Re-running is safe and idempotent.
# =============================================================================

set -euo pipefail

REPO_ROOT="$(git rev-parse --show-toplevel)"
HOOKS_DIR="${REPO_ROOT}/scripts/git-hooks"

if [[ ! -d "$HOOKS_DIR" ]]; then
  echo "ERROR: hooks directory not found at $HOOKS_DIR" >&2
  exit 1
fi

chmod +x "${HOOKS_DIR}"/*

git config core.hooksPath "scripts/git-hooks"

echo "✓ Git hooks installed."
echo "  core.hooksPath → scripts/git-hooks"
echo "  Active hooks:"
ls -1 "$HOOKS_DIR" | sed 's/^/    - /'
