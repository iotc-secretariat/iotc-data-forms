# ROS LL reporting form — v4.2.0

## Source

Status: working draft.

Source: [SWIOP D3 workbook](https://github.com/ultreia-io/iotc-swiop-1.2/blob/83798c189b566529734503354fdf4878e6dac8fa/deliverables/D3/sources/Form-ROS-LL-v4.2.0.xlsx).

Change reference: [V4.2.0 checklist](https://github.com/ultreia-io/iotc-swiop-1.2/blob/83798c189b566529734503354fdf4878e6dac8fa/deliverables/D3/report/ros-v3-to-v4/07_v4.2.0-workbook-checklist.md).

## Changes

- Set the form version in `META!G4` to `4.2.0`.
- Change the flag / chartering state reference in `META!C20` from Fleets to Countries.
- Correct the Ports links in `O-INFO!E4/J4`, `V-INFO!H2` and `V-TRIP!C3/H3`.
- Update both condition links in `E-SET-CATCH-SPECIMENS-SSI!E1/F1` to the current biology catalogue.
- Update the species link in `E-SET-CATCHES!D1` to the All Species catalogue.
- Add the Hull Material Types link in `V-ATTRIBUTES!D2`.
- Update the bait-species link in `E-SET-BAITS!D2` to the Bait Species catalogue.
- Update predator-species links in `E-SET-CATCH-SPECIMENS!W2` and `E-SET-CATCH-SPECIMENS-SSI!T2`.
- Correct the length-measurement link in `E-SET-CATCH-SPECIMENS!G2` to All Measurements.
- Correct the weight-estimation link in `E-SET-CATCH-SPECIMENS!O2` to Weight Measurement Tools.
- Add the Hook and Terminal Devices link in `E-SET-CATCH-SPECIMENS-SSI!H1`.
- Rename the minimum and maximum branchline lengths to `BRANCHLINE_LENGTH_MIN_M` and `BRANCHLINE_LENGTH_MAX_M`.
- Remove the two separate branchline-length unit columns in `E-SET`; both lengths are expressed in metres.
- Update the four species links in `E-SET!Y3:AB3` to All Species.
- Add optional `TORI_LINE_SKETCH_IN_TRIP_REPORT` in `G-CONFIG-MITIGATION-DEVICES!L2`.
- Link the new sketch field to Logical Responses; it records whether the observer trip report includes the sketch.

## Pending decisions

Floatline lengths, distance between branchlines and radio/dhan buoy count await IOTC confirmation.
