# AI Skills

Personal collection of AI CLI skills, managed with [Skillshare](https://skillshare.runkids.cc/) and synced across multiple AI tools.

## Installed Skills

| Skill | Description |
|-------|-------------|
| **agent-browser** | Browser automation CLI for AI agents — navigate pages, fill forms, click buttons, take screenshots, extract data, test web apps |
| **dogfood** | Systematically explore and test web applications to find bugs, UX issues, and other problems with full reproduction evidence |
| **electron** | Automate Electron desktop apps (VS Code, Slack, Discord, Figma, Notion, etc.) via Chrome DevTools Protocol |
| **find-skills** | Discover and install agent skills from the open skills ecosystem |
| **generate-image** | Generate images using Nano Banana 2 (Gemini 3.1 Flash Image) for websites, illustrations, icons, and backgrounds |
| **gstack** | Fast headless browser for QA testing and site dogfooding (~100ms per command). Includes sub-skills: browse, document-release, gstack-upgrade, plan-ceo-review, plan-eng-review, qa, qa-only, retro, review, setup-browser-cookies, ship |
| **skill-creator** | Guide for creating and updating skills that extend AI CLI capabilities |
| **skillshare** | Manages and syncs AI CLI skills across 50+ tools from a single source |
| **slack** | Interact with Slack workspaces using browser automation — check unreads, send messages, search conversations |

## Sync Targets

Skills are synced to the following AI tools via **symlink** mode:

| Target | Path |
|--------|------|
| Claude Code | `~/.claude/skills` |
| Codex | `~/.codex/skills` |
| Cursor | `~/.cursor/skills` |
| Gemini CLI | `~/.gemini/skills` |
| Antigravity | `~/.gemini/antigravity/skills` |
| Droid | `~/.factory/skills` |
| OpenCode | `~/.config/opencode/skills` |
| Universal | `~/.agents/skills` |

## Setup on a New Machine

### 1. Install Skillshare

```bash
# macOS / Linux
curl -fsSL https://raw.githubusercontent.com/runkids/skillshare/main/install.sh | sh

# Homebrew
brew install skillshare
```

### 2. Clone this repo as your skill source

```bash
skillshare init --remote https://github.com/rayzhux/skills.git
```

This will pull all skills and auto-detect installed AI tools as sync targets.

### 3. Sync to all targets

```bash
skillshare sync
```

## Daily Workflow

```bash
# Check status
skillshare status

# Preview changes before syncing
skillshare sync --dry-run

# Sync skills to all AI tools
skillshare sync

# Install a new skill
skillshare install <github-user/repo>
skillshare sync

# Push changes to remote (for cross-machine sync)
skillshare push -m "Add new skill"

# Pull changes on another machine
skillshare pull
```

## Useful Commands

```bash
# List all installed skills
skillshare list

# Show differences between source and targets
skillshare diff

# Collect a skill you created locally in an AI tool back to source
skillshare collect claude

# Create a new skill from template
skillshare new my-skill

# Security audit
skillshare audit

# Check for skill updates
skillshare check

# Update all tracked repos
skillshare update --all

# Upgrade Skillshare CLI
skillshare upgrade
```

## Configuration

Config file: `~/.config/skillshare/config.yaml`

- **Sync mode**: `symlink` — the target directory is a symlink to source. Edits in any target edit the source directly.
- **Audit threshold**: `CRITICAL` — blocks only critical security issues on install.

## Notes

- In symlink mode, deleting files in a target directory deletes them from source. Use `skillshare target remove <name>` to safely unlink.
- Skills with a `targets` field in their `SKILL.md` frontmatter only sync to specified targets.
- Run `skillshare doctor` to diagnose environment issues.
