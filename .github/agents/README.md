# Code reviewer personas (Copilot custom agents)

Each file here is a GitHub Copilot **custom agent**: YAML frontmatter plus a Markdown
prompt that defines one reviewer persona.

## Why custom agents and not instructions or skills

| Option | Path | Behavior |
| --- | --- | --- |
| **Custom agent** | `.github/agents/<name>.md` | A selectable persona. You pick which reviewer runs. Works on GitHub.com, VS Code, and Copilot CLI. |
| Custom instructions | `.github/copilot-instructions.md`, `.github/instructions/*.instructions.md` | Always applied (optionally path-scoped). Not selectable, so it cannot express distinct personas. |
| Skills | Agent-side capability packages | Not a first-party GitHub code review surface. |

Since each persona should be chosen per pull request, custom agents are the correct
construct.

## Installing

Copy the `.md` files into one of:

- `.github/agents/` in a single repository — available to that repository.
- `.github/agents/` in your organization's `.github` repository — available org-wide.

The filename (minus `.md`) is the agent's identifier and is what deduplicates repository,
organization, and enterprise definitions, with the most local winning.

## Using

- **GitHub.com**: select the agent when delegating a task or requesting a review from Copilot.
- **VS Code**: choose it from the agent picker in Chat.
- **Copilot CLI**: `copilot --agent security-reviewer`.

## Frontmatter used

```yaml
---
name: Security Reviewer            # display name (optional)
description: ...                   # required; used by the picker and by model selection
tools: ["read", "search", "github/*"]  # read-only: review, don't edit
---
```

Omit `tools` to grant everything. These personas deliberately exclude `edit` and
`execute` so a reviewer reports rather than rewrites. Add `"edit"` if you want an agent
to be able to apply its own suggested fixes.

Optional additions:

- `model:` pin a model for the persona.
- `target: github-copilot` or `vscode` to limit where the agent appears.
- `disable-model-invocation: true` to require the agent be chosen explicitly rather than
  auto-selected from task context.

The prompt body is capped at 30,000 characters.

## Personas

| File | Persona |
| --- | --- |
| `security-reviewer.md` | Application security |
| `performance-reviewer.md` | Performance and scalability |
| `data-science-reviewer.md` | Data, statistics, and ML validity |
| `devops-reviewer.md` | Infrastructure, CI/CD, and operability |
| `accessibility-reviewer.md` | WCAG 2.2 AA accessibility |

## Writing more personas

Keep the same shape so results stay comparable:

1. **Role** — one paragraph, including what the persona does *not* do.
2. **Review scope** — a bulleted checklist of the specific defect classes it owns.
3. **Rules** — signal-to-noise guardrails and explicit non-goals.
4. **Output** — a one-line verdict, then a fixed finding format, then open questions.

Non-overlapping scopes matter most: if two personas both report the same issue, you lose
the benefit of running several.
