#!/usr/bin/env bash
set -euo pipefail

usage() {
  echo "Usage: $0 --branch <ai/auto-pr/topic> --title <title> --body-file <file.md> [--labels <csv>] [--dry-run]"
  exit 1
}

BRANCH=""; TITLE=""; BODY_FILE=""; LABELS="ai-bot"; DRYRUN="false"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --branch) BRANCH="$2"; shift 2;;
    --title) TITLE="$2"; shift 2;;
    --body-file) BODY_FILE="$2"; shift 2;;
    --labels) LABELS="$2"; shift 2;;
    --dry-run) DRYRUN="true"; shift 1;;
    *) usage;;
  esac
done

[[ -z "${BRANCH}" || -z "${TITLE}" || -z "${BODY_FILE}" ]] && usage
[[ "${BRANCH}" != ai/auto-pr/* ]] && { echo "Branch must start with ai/auto-pr/"; exit 2; }
[[ -f "${BODY_FILE}" ]] || { echo "Body file not found: ${BODY_FILE}"; exit 3; }

# gh login: gebruik bestaande sessie; anders PAT via env
if ! gh auth status >/dev/null 2>&1; then
  [[ -n "${AI_GITHUB_TOKEN:-}" ]] || { echo "Missing AI_GITHUB_TOKEN env var and no gh auth session."; exit 4; }
  gh auth login --with-token <<< "${AI_GITHUB_TOKEN}"
fi

git config user.name "[AI-BOT]"
git config user.email "ai-bot@yourdomain.example"

# Branch maken (of switchen als hij al bestaat)
if git rev-parse --verify "${BRANCH}" >/dev/null 2>&1; then
  git checkout "${BRANCH}"
else
  git checkout -b "${BRANCH}"
fi

# 👉 Hier kan een AI-tool wijzigingen genereren (provider-CLI). Voor nu: commit wat er staged is.
if ! git diff --quiet || ! git diff --cached --quiet; then
  git add -A
  git commit -m "chore(${BRANCH#ai/auto-pr/}): automated change by AI"
else
  echo "No changes detected to commit."
fi

if [[ "${DRYRUN}" == "true" ]]; then
  echo "[DRY-RUN] Skipping push/PR creation."
  exit 0
fi

git push -u origin "${BRANCH}"

gh pr create \
  --title "${TITLE}" \
  --body-file "${BODY_FILE}" \
  --label "${LABELS}" \
  --head "${BRANCH}"
