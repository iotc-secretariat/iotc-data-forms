# IOTC Data Forms

Repository for managing, versioning and disseminating the fisheries statistics reporting forms and Regional Observer Scheme (ROS) data collection and reporting forms developed by the Indian Ocean Tuna Commission (IOTC) Secretariat.

The repository contains two collections:

- **Fisheries statistics reporting forms**, used by IOTC Contracting Parties and Cooperating Non-Contracting Parties (CPCs) to submit fisheries data.
- **Regional Observer Scheme (ROS) forms**, used to collect and report scientific observer data.

## Fisheries statistics reporting forms

The fisheries statistics forms support standardised reporting of fisheries data to the IOTC Secretariat. The collection was initially published on [Zenodo](https://zenodo.org/records/16941788) in 2025.

Form descriptions and associated reference information are available in the [IOTC Data Reporting Forms catalogue](https://data.iotc.org/reference/latest/forms/).

The collection includes:

- **1DR**: Species presence in the catch
- **1IN**: Interactions of longline and surface fisheries with endangered, threatened and protected (ETP) species
- **1RC**: Amount of fish caught and retained
- **1DI**: Amount of discards
- **3CE**: Georeferenced catches and fishing effort
- **3AA**: Activities related to anchored fish aggregating devices
- **3BU**: Daily buoy positions
- **3DA**: Interactions related to drifting floating objects
- **4SF**: Georeferenced size frequencies
- **2FC**: Fishing craft statistics
- **5MB**: Individual-level morphometric and biological data
- **6LG**: Data and information on the recovery of abandoned, lost or discarded fishing gear
- **7PR**: Prices of fish products for tuna and tuna-like species under the IOTC mandate

Each form has its own directory. Version numbers are included in the Excel workbook filenames, and release information is maintained with the relevant form rather than in this repository-level README.

## Regional Observer Scheme (ROS) forms

ROS forms support the standardised collection and reporting of scientific observer data from fisheries operating in the IOTC area of competence.

Form-specific documentation is available for:

- [Longline (LL)](form_reporting_templates/LL/README.md)
- [Purse seine (PS)](form_reporting_templates/PS/README.md)

Refer to the form-specific README files for available versions, release status and associated documentation.

## Versioning and repository organisation

Both collections use version numbers following the `MAJOR.MINOR.PATCH` convention (for example, `vX.Y.Z`). Version increments are defined as follows:

| Component | When to increment |
|---|---|
| **MAJOR** (`X`) | Changes to the form structure or data requirements that break compatibility with previous versions. |
| **MINOR** (`Y`) | Backwards-compatible additions or enhancements, such as new optional fields or functionality. |
| **PATCH** (`Z`) | Corrections that do not change the expected data structure, such as fixes to labels, instructions or validation rules. |

Forms are organised by form type, with version identifiers included in workbook filenames. Each version is stored in a dedicated directory containing the corresponding workbook and a `CHANGELOG.md` describing the changes introduced.

For example, the ROS reporting forms use the following structure:

    form_reporting_templates/LL/
    ├── README.md
    └── vX.Y.Z/
        ├── Form-ROS-LL-vX.Y.Z.xlsx
        └── CHANGELOG.md

When publishing a new version:

1. Create a new `vX.Y.Z/` directory under the relevant form type.
2. Include the version number in the workbook filename.
3. Document the changes in the version-specific `CHANGELOG.md`.
4. Update the form-specific `README.md` with links to the workbook and changelog, including the release status.

**Published workbooks must remain unchanged.** Corrections and other modifications should be released as new versions to preserve traceability and reproducibility.

For current releases and their status, consult the relevant form-specific README files and changelogs.
