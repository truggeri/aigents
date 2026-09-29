---
name: code-review
description: Apply the repository's security, performance, data science, DevOps, and accessibility reviewer checks during pull request reviews. Use this skill for code review tasks.
---

# Code review personas

Use the relevant checks below when reviewing a pull request. Review only changed
lines and the code paths they touch. Report concrete, actionable findings rather
than style preferences or speculative concerns.

## Security reviewer

Check for:

- Injection: SQL, NoSQL, command, template, LDAP, XPath, and unsafe deserialization.
- Authentication and authorization failures, IDOR, privilege escalation, tenant
  isolation, and unsafe session or token handling.
- Credentials, tokens, or keys committed, logged, or sent to third parties.
- Missing validation or encoding, XSS, SSRF, path traversal, unsafe uploads, and
  unbounded parsing.
- Weak cryptography, hardcoded keys or IVs, insecure randomness, and missing
  signature or certificate verification.
- New dependencies, unpinned versions, unverified downloads, and workflows that run
  untrusted input.
- `pull_request_target` misuse, script injection from event data, and excessive token
  permissions.

Report only findings with a concrete exploitation path. If existing controls mitigate
the concern, drop it.

## Performance reviewer

Check for:

- Algorithmic complexity regressions, repeated scans, N+1 queries, and unnecessary
  serialization or network calls.
- Unbounded memory, CPU, disk, queue, or connection-pool usage.
- Blocking work on latency-sensitive or event-loop threads.
- Missing pagination, batching, caching, backpressure, timeouts, or cancellation.
- Contention, lock scope, concurrency hazards, and inefficient database access.
- Changes that degrade startup, throughput, tail latency, or horizontal scalability.

Tie findings to a realistic workload or measurable impact; do not report micro-
optimizations without evidence.

## Data science reviewer

Check for:

- Target leakage, train/test contamination, temporal leakage, and incorrect splits.
- Invalid experiment design, biased sampling, missing baselines, and irreproducible
  randomness.
- Metrics that do not match the product objective, class imbalance, threshold
  misuse, or misleading aggregation.
- Incorrect statistical assumptions, uncertainty reporting, multiple comparisons, or
  causal claims unsupported by the design.
- Feature/label transformations that differ between training and serving.
- Missing data quality checks, drift monitoring, or safeguards for sensitive data.

Separate correctness issues from reasonable modeling choices and explain the failure
mode with a concrete example where possible.

## DevOps reviewer

Check for:

- Unsafe deployment or rollback behavior, missing health checks, and migrations that
  cannot be rolled back or run safely during mixed-version operation.
- CI/CD failures, cache poisoning, unpinned actions or images, secret exposure, and
  excessive permissions.
- Missing resource limits, probes, timeouts, retries, idempotency, or graceful
  shutdown.
- Configuration drift, environment-specific assumptions, and observability gaps.
- Changes that can cause data loss, downtime, runaway cost, or difficult recovery.

Consider failure modes, blast radius, operational ownership, and how an operator
would diagnose and recover from the change.

## Accessibility reviewer

For UI changes, evaluate against WCAG 2.2 Level AA:

- Native semantics, roles, heading order, landmarks, and list structure.
- Keyboard reachability and operation, logical tab order, visible focus, no traps,
  and correct focus management for dialogs and menus.
- Accessible names, labels, associated errors, and live-region announcements.
- Text contrast under SC 1.4.3, including large-text and incidental-text/logotype
  exceptions; non-text contrast under SC 1.4.11 only for visual information needed
  to identify components or states; and no color-only communication.
- Reflow at 200% zoom and 320px width, reduced motion, timing, forms, alt text,
  captions, and transcripts.

Describe the barrier in terms of a user's experience and name the specific success
criterion. Do not flag visual preferences without an accessibility consequence.

## Output

Start with one line: `Blocking findings`, `Non-blocking concerns`, or `No issues found`.
For each finding, include:

- **Severity**: Critical / High / Medium / Low
- **Persona**: Security / Performance / Data science / DevOps / Accessibility
- **Location**: `path/to/file.ext:line`
- **Issue**: what is wrong and why it matters
- **Impact**: the concrete user, system, or business consequence
- **Fix**: the minimal concrete change

End with open questions or manual checks that a human should confirm.
