# ROS LL reporting form — v4.2.0

## Source

Status: working draft.

Source: [SWIOP D3 workbook](https://github.com/ultreia-io/iotc-swiop-1.2/blob/83798c189b566529734503354fdf4878e6dac8fa/deliverables/D3/sources/Form-ROS-LL-v4.2.0.xlsx).

Change reference: [V4.2.0 checklist](https://github.com/ultreia-io/iotc-swiop-1.2/blob/83798c189b566529734503354fdf4878e6dac8fa/deliverables/D3/report/ros-v3-to-v4/07_v4.2.0-workbook-checklist.md).

## Changes

- [Change meta value] Form version (`META!G4`) to `4.2.0`.
- [Add column] `TORI_LINE_SKETCH_IN_TRIP_REPORT` in `G-CONFIG-MITIGATION-DEVICES!L2` (optional).
- [Add column] `E-SET` / `NUMBER_RADIO_DHAN_BUOYS_SET`: optional integer.
- [Add column] `E-SET` / `FLOATLINE_LENGTH_1_M`: mandatory length in metres.
- [Add column] `E-SET` / `FLOATLINE_LENGTH_2_M`: optional length in metres.
- [Add column] `E-SET` / `FLOATLINE_LENGTH_3_M`: optional length in metres.
- [Add column] `E-SET` / `DISTANCE_BETWEEN_BRANCHLINES_M`: optional distance in metres.
- [Remove column] the two separate branchline-length unit columns in `E-SET`; both lengths are expressed in metres.
- [Rename column] the minimum and maximum branchline lengths to `BRANCHLINE_LENGTH_MIN_M` and `BRANCHLINE_LENGTH_MAX_M`.
- [Fix link] the flag / chartering state reference in `META!C20` from Fleets to Countries.
- [Fix link] the Ports links in `O-INFO!E4/J4`, `V-INFO!H2` and `V-TRIP!C3/H3`.
- [Fix link] both condition links in `E-SET-CATCH-SPECIMENS-SSI!E1/F1` to the current biology catalogue.
- [Fix link] the species link in `E-SET-CATCHES!D1` to the All Species catalogue.
- [Fix link] the bait-species link in `E-SET-BAITS!D2` to the Bait Species catalogue.
- [Fix link] predator-species links in `E-SET-CATCH-SPECIMENS!W2` and `E-SET-CATCH-SPECIMENS-SSI!T2`.
- [Fix link] the length-measurement link in `E-SET-CATCH-SPECIMENS!G2` to All Measurements.
- [Fix link] the weight-estimation link in `E-SET-CATCH-SPECIMENS!O2` to Weight Measurement Tools.
- [Fix link] the four species links to All Species; their final positions are `E-SET!AD3:AG3`.
- [Fix link] `G-CONFIG-MITIGATION-DEVICES!L2` to Logical Responses.
- [Fix link] the obsolete `longimanus` URL in `V-ATTRIBUTES!D2:D3` with the current Hull Material Types URL.
- [Fix link] `E-SET-CATCHES!E2` to Fate Types.
- [Fix link] `E-SET-CATCH-SPECIMENS!F1:F2` to Sampling Methods for Sampling Collections.
- [Fix link] `E-SET-CATCH-SPECIMENS-SSI!H1:H2` to Hook and Terminal Devices.
- [Fix link] `V-INFO!J1` to Target Species in the current fisheries catalogue.
- [Fix link] the remaining Ports anchor in `V-INFO!H2:H3`.
