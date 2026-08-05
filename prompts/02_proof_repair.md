# Proof Repair

You receive a Lean theorem, the current proof candidate, and the exact compiler
error. Propose one minimal edit. Do not introduce `sorry`, `admit`, axioms,
`native_decide`, or compiler-trust shortcuts. Explain what the error means, then
return only the replacement proof block. The candidate is not considered valid
until Lean compiles it.
