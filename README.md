# aigents

Reusable GitHub Copilot **reviewer personas** for delegated reviews and native
Copilot PR reviews. The personas are defined as custom agents in
[`.github/agents/`](.github/agents/README.md), with a combined review skill in
[`.github/skills/code-review/`](.github/skills/code-review/SKILL.md).

## Install

Copy the desired `.md` file(s) from `.github/agents/` into:

- `.github/agents/` of a target repository, to make them available there, or
- `/agents/` of your organization's `.github` or `.github-private` repository, to make
  them available org-wide.

### Personal install (local machine or Codespaces)

`install.sh` symlinks the agents and skills into `~/.copilot/agents` and
`~/.copilot/skills`, where Copilot CLI and VS Code load personal customizations:

```sh
git clone https://github.com/truggeri/aigents && ./aigents/install.sh
```

Links point back into the clone, so `git pull` picks up updates. Existing non-symlink
files are left untouched.

To install into every new codespace, go to
[Codespaces settings](https://github.com/settings/codespaces), enable
**Automatically install dotfiles**, and select this repository. Codespaces clones it
and runs `install.sh` on creation.

## Use

- **Native GitHub PR review**: request Copilot as a reviewer. Copilot code review
  can use the repository's `code-review` skill, but does not provide a custom-agent
  picker for `.github/agents/*.md`.
- **Delegated GitHub.com task**: pick a custom agent from the agent picker and ask it
  to review the pull request.
- **VS Code**: choose it from the Chat agent picker.
- **Copilot CLI**: `copilot --agent <name>` (e.g. `copilot --agent security-reviewer`).

See [`.github/agents/README.md`](.github/agents/README.md) for the full list of
personas and custom-agent format. See the
[review skill](.github/skills/code-review/SKILL.md) for the native PR-review path.
