# aigents

Reusable GitHub Copilot **custom agents** — a set of code-reviewer personas (security,
performance, data science, DevOps, accessibility) defined in
[`.github/agents/`](.github/agents/README.md).

## Install

Copy the desired `.md` file(s) from `.github/agents/` into:

- `.github/agents/` of a target repository, to make them available there, or
- `/agents/` of your organization's `.github` or `.github-private` repository, to make
  them available org-wide.

## Use

- **GitHub.com**: pick the agent from the agent picker when delegating a task or
  requesting a review from Copilot.
- **VS Code**: choose it from the Chat agent picker.
- **Copilot CLI**: `copilot --agent <name>` (e.g. `copilot --agent security-reviewer`).

See [`.github/agents/README.md`](.github/agents/README.md) for the full list of personas,
the frontmatter format, and how to write additional ones.
