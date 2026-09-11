# C — Item Response Theory

Study 1PL/Rasch, 2PL, 3PL, local independence, unidimensionality, item characteristic curves, difficulty, discrimination, guessing, item/test information, MLE/MAP/EAP ability estimation, posterior/SE uncertainty, fit diagnostics, parameter recovery, and MIRT.

## OpenIQ decisions

- begin by reproducing the exact MaRs model rather than picking a favorite IRT model;
- use R/`mirt` as the reference implementation;
- test production scoring numerically against the reference;
- never assume theta from two independent calibrations is on the same scale.

## First exercise

From MaRs public data, recover published item parameters/information and calculate theta + uncertainty for synthetic response patterns.
