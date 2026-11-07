# Task 02 Solution

The minimal disagreement is cancellation requested while a path is also
available. The reference tree checks cancellation first; the buggy FSM checks
path availability first.

The repair is to restore the reference priority order. The Lean proof then
case-splits the three Boolean observations and checks every branch exactly.

This branch is the parent checkpoint of `workshop/03-vda-trace`.
