# iotc-ros-forms
Repository for managing and disseminating the IOTC collection and reporting forms of the Regional Observer Scheme

## Versioned reporting forms

The versioned layout currently applies to the LL and PS reporting forms.

- [Longline (LL)](form_reporting_templates/LL/README.md)
- [Purse seine (PS)](form_reporting_templates/PS/README.md)

Each form type has one directory per version, containing the workbook and its own `CHANGELOG.md`.

Example:

```text
form_reporting_templates/LL/
├── README.md
└── v4.1.0/
    ├── Form-ROS-LL-v4.1.0.xlsx
    └── CHANGELOG.md
```

For each new version:

1. Add a `vX.Y.Z/` directory under the relevant form type.
2. Include the version in the workbook filename.
3. Add a version-specific changelog describing the changes.
4. Add links to the workbook and changelog in the form type README.

Keep published workbooks unchanged; corrections belong in a new version.

Versions 3.3.0, 4.0.0, 4.1.0 and 4.2.0 are available for LL and PS reporting forms.

Version 4.2.0 contains working drafts; see each version-specific changelog for provenance and status.
