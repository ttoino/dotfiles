# Global Agent Guide

## Environment

This machine runs **NixOS**. Many binaries commonly available on other Linux distributions are not installed globally. When you need a tool or package that is not available:

- Use `nix-shell -p <package>` or `nix run nixpkgs#<package>` to temporarily access it
- Prefer your own built-in tools when possible
- Do not assume standard POSIX tools beyond the very basics are present

## Commit Style

Use the following commit message conventions:

- Imperative mood
- Sentence case, no trailing period
- Present tense
- Concise and descriptive
- Common verbs: `Add`, `Remove`, `Fix`, `Use`, `Update`, `Move`, `Show`, `Make`, `Set`, `Switch`, `Restructure`, `Migrate`, `Format`, `Get`, `List`, `Regenerate`, `Upgrade`, `Bump`, `Apply`

## Skills

Always use a **skill** whenever one is available for the task at hand. Skills provide specialized, accurate instructions for specific domains.

## MCP Servers

Always use an **MCP server** whenever one is available for the task at hand. MCP servers provide specialized tools and integrations for specific domains.

## Git Safety

**Always ask for explicit permission before running `git commit`, `git push`, or any other git mutation command.** Never assume it is okay to commit or push changes without the user explicitly confirming.
