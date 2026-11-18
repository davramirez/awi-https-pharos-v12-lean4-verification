/-
AWI Research Lab — Public abstract Boolean authorization model.
Technical report: AWI-HTTPS-S67-S68-G20.
This file contains only public-facing model definitions, not implementation code.
-/
namespace AWI.PharosV12Public

structure AuthorityVector where
  identity : Bool
  consent : Bool
  tenantScope : Bool
  effectPermit : Bool
  notRevoked : Bool
  freshNonce : Bool
  deriving DecidableEq, Repr

def phiGate (v : AuthorityVector) : Bool :=
  v.identity && v.consent && v.tenantScope &&
  v.effectPermit && v.notRevoked && v.freshNonce

def allAuthorized : AuthorityVector :=
  ⟨true, true, true, true, true, true⟩

theorem no_effect_permit (i c t r n : Bool) :
    phiGate ⟨i, c, t, false, r, n⟩ = false := by
  simp [phiGate]

theorem revoked_denied (i c t p n : Bool) :
    phiGate ⟨i, c, t, p, false, n⟩ = false := by
  simp [phiGate]

theorem replay_denied (i c t p r : Bool) :
    phiGate ⟨i, c, t, p, r, false⟩ = false := by
  simp [phiGate]

theorem phiGate_true_iff_allAuthorized (v : AuthorityVector) :
    phiGate v = true ↔ v = allAuthorized := by
  cases v with
  | mk i c t p r n =>
    cases i <;> cases c <;> cases t <;> cases p <;>
      cases r <;> cases n <;> simp [phiGate, allAuthorized]

structure DiscoveryEdge where
  proposed : Bool
  acknowledged : Bool
  withinDegCap : Bool
  deriving DecidableEq, Repr

def lighthouseAdmitted (e : DiscoveryEdge) : Bool :=
  e.proposed && e.acknowledged && e.withinDegCap

theorem discovery_does_not_grant_effect_permit
    (e : DiscoveryEdge) (v : AuthorityVector)
    (_h : lighthouseAdmitted e = true) (hp : v.effectPermit = false) :
    phiGate v = false := by
  cases v with
  | mk i c t p r n =>
    cases p <;> simp_all [phiGate]

def falsePermissiveCandidate : AuthorityVector :=
  ⟨true, true, true, false, true, true⟩

theorem false_permissive_candidate_denied :
    phiGate falsePermissiveCandidate = false := by
  decide

end AWI.PharosV12Public
