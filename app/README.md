# Assessment Application

The application is an administration shell around versioned research artifacts. It must not invent psychometrics.

## v0.1 responsibilities

- consent/instruction boundary appropriate to personal/research mode
- practice flow
- immutable form manifest and item version IDs
- response capture
- response-time capture as metadata (not an automatic ability bonus)
- device/browser/input/focus metadata
- deterministic scoring call into a versioned model
- report with theta, uncertainty, reference sample, form/model version, and limitations

## Non-responsibilities

The UI must not:

- create an IQ score from `% correct`;
- mix milliseconds into reasoning ability with an arbitrary penalty;
- silently change item geometry/text/distractors;
- hide the calibration population;
- describe v0.1 as Full Scale IQ.

## Personal baseline isolation

The final scored personal form should be assembled/frozen without exposing its item content to the person taking the baseline. Use separate sandbox/practice items during development.
