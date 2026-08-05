import VerifiedAgenticWorkshop.Scenarios.VDA5050Trace

namespace VerifiedAgenticWorkshop.Solutions.VDA5050Trace

open VerifiedAgenticWorkshop.Scenarios.VDA5050Trace

theorem valid_trace_accepted :
    run initial validTrace = some ⟨some 7, 1, 4⟩ := by
  decide

theorem stale_update_rejected :
    run initial staleUpdateTrace = none := by
  decide

theorem regressing_state_rejected :
    run initial regressingStateTrace = none := by
  decide

end VerifiedAgenticWorkshop.Solutions.VDA5050Trace
