# AWI → HTTPS · PHAROS V11–V12 · Lighthouse G20

**Public reproducible authorization-model package**  
David Ramirez · AWI Research Lab · November 18, 2026

[Flagship technical dispatch](https://awiresearch.com/research/awi-https-v12-lighthouse-g20-dispatch/) · [Interactive security demo](https://awiresearch.com/ai-security-demo/) · [Lighthouse research bibliography](https://awiresearch.com/research-lighthouse/) · [Founder commentary](https://davramirez.com/the-900-second-suicide-pact-awi-https-lighthouse-g20/)

This repository exposes a **small, self-contained Lean 4.35.0 specification** of a six-condition authorization gate, plus **eight illustrative Python model checks** of recurring cloud-agent security failure modes. It is public source for technical discussion, **not** the original private V11/V12 broker implementation or its original adversarial test suite.

## Why model this boundary?

Discovering an agent or verifying its identity does not entitle it to take action. In the public Boolean model, execution admission requires all six conditions: identity, owner consent, tenant scope, effect permit, non-revocation, and freshness of a single-use nonce.

`Discover → Propose → Authorize → Prepare → Execute → Verify`

The Lean model proves that a missing effect permit, a revoked permit, or a reused nonce denies authorization. It also checks that only one of 64 possible Boolean vectors satisfies the conjunction. A deliberately false authorization theorem was rejected by the Lean 4.35.0 compiler.

## Verify the public model

Prerequisites: Python 3.10+; Lean 4.35.0. No cloud account, SDK, production permission or external network access is needed.

```bash
python3 counterexamples/reproduce_8_cloud_flaws.py
lean lean4/PharosV12PublicSpec.lean
```

**Observed author-side verification, November 18, 2026:** Lean 4.35.0 compilation exit 0; positive compiled `.olean` artifact; `leanchecker` module verification exit 0; deliberately false theorem rejected by `decide` with nonzero exit; Python illustrative checks 8/8 pass. See [VERIFICATION.md](VERIFICATION.md) for the exact scope.

These tests are **abstract-model evidence**. They do not prove a deployed AWS control, a one-to-one implementation correspondence, Byzantine resistance, or superiority to a native Kademlia deployment. AWS STS role sessions have a 900-second requested minimum; AWS also documents IAM mechanisms for revoking existing role-session permissions. Distinguishing credential duration from independently enforced authorization is the systems issue.

Lighthouse addresses degree-bounded discovery, not the assignment of execution authority. In later G21 toy tests, both Lighthouse and a Kademlia-like comparator completed 94/94 lookup pairs; this is **parity in the tested model**, not demonstrated network superiority.

## Source and licensing

The self-contained public models in this repository are examples, not copies of protected research core source or private cloud credentials. The author retains copyright; no open-source license has been granted in this repository.

**Research attribution:** David Ramirez, AWI Research Lab. See [CITATION.cff](CITATION.cff).

**Research principle:** AI proposes. Evidence decides.
