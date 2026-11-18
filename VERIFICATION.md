# Reproducibility and source evidence

**Verified on the owner's connected Mac, November 18, 2026.**

| Check | Result |
|---|---|
| Lean toolchain | Lean 4.35.0, arm64-apple-darwin24.6.0, release commit eb6cafb7290e8bd5f2937522d8d804f58f02bafc |
| Lean source SHA-256 | \`25e2e6dbfed36b00226180cd552039d630cc108ff9718708a09c7c4e0dca7a73\` |
| \`lean lean4/PharosV12PublicSpec.lean\` | Exit 0 |
| \`lean -o PharosV12PublicSpec.olean PharosV12PublicSpec.lean\` | Exit 0, 642 KB \`.olean\` |
| \`leanchecker PharosV12PublicSpec\` with module search path set | Exit 0 |
| Negative theorem \`phiGate falsePermissiveCandidate = true := by decide\` | Expected exit 1: \`Tactic decide proved that the proposition ... is false\` |
| Python model checks | 8/8 pass, no network or AWS calls |

The Lean proofs are abstract Boolean-state properties. They do not verify a cloud implementation, code/runtime conformance, cryptographic custody, production deployment or independent TEVV. The Python script is a set of eight *illustrative scenarios* rather than the original V12 cloud-broker regression harness.

## Local reproducibility

\`\`\`sh
lean lean4/PharosV12PublicSpec.lean
python3 counterexamples/reproduce_8_cloud_flaws.py
\`\`\`

To separately check the compiled artifact, invoke \`lean -o PharosV12PublicSpec.olean PharosV12PublicSpec.lean\` from the \`lean4\` directory and then \`LEAN_PATH=. leanchecker PharosV12PublicSpec\`.

The protected AA/BUBi Oracle and associated custody material are not part of this repository.
