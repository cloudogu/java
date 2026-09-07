# Jenkins Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [11.0.32-1] - 2026-09-07
### Changed
- Upgrade OpenJDK to v11.0.32
- Upgrade base-image to v3.24.1-1

## [11.0.31-2] - 2026-06-24
### Changed
- Upgrade base-image to v3.24.1-1

## [11.0.31-1] - 2026-06-15
### Changed
- Upgrade OpenJDK to v11.0.31
- Upgrade base-image to v3.24.0-1

## [11.0.30-5] - 2026-03-25
### Changed
- Upgrade base-image to v3.23.3-6

## [11.0.30-4] - 2026-03-10
### Changed
- Upgrade base-image to v3.23.3-5

## [11.0.30-3] - 2026-02-17
### Fixed
- [#91] Upgrade base-image to 3.23.3-4
  - This fixes a bug in doguctl, to not check the local config if volume is not mounted.

## [11.0.30-2] - 2026-02-12
### Security
- [#91] Upgrade base-image to 3.23.3-3
    - [#91] Update doguctl to v0.15.0 to fix [CVE-2025-61732](https://avd.aquasec.com/nvd/2026/CVE-2025-61732) and [CVE-2025-68121](https://avd.aquasec.com/nvd/2026/CVE-2025-68121).

## [11.0.30-1] - 2026-02-02
### Changed
- Upgrade Java to 11.0.30_p7-r0

## [11.0.29-2] - 2025-12-10
### Changed
- Upgrade base-image to 3.23.0-1

## [11.0.29-1] - 2025-12-02
### Changed
- Upgrade base-image to 3.22.0-5
- Upgrade Java to 11.0.29

## [11.0.25-1] - 2025-01-02
### Changed
- [#75] Upgrade base image to 3.21.0-1
- [#75] Upgrade java to 11.0.25_p9-r0

### Security
- [#75] Fixes CVE-2024-45337

## [11.0.24-3] - 2024-09-18
### Changed
- Relicense to AGPL-3.0-only

## [11.0.24-2] - 2024-09-17
### Changed
- [#58] Upgrade base-image to v3.20.3-1

## [11.0.24-1] - 2024-08-06
### Changed
- [#49] Upgrade base-image to v3.20.2-1
- [#49] Upgrade OpenJDK to 11.0.24 

### Security
- this release closes CVE-2024-41110

## [11.0.23-3] - 2024-06-25
### Changed
- [#43] Update Base Image to v3.20.1-2

### Security
- this release closes the following CVEs
    - CVE-2024-24788
    - CVE-2024-24789
    - CVE-2024-24790

## [11.0.23-2] - 2024-06-25
### Changed
- Upgrade to base image 3.20.1-1 (#41)
    - Contains doguctl v0.11.0
- Update makefiles to 9.0.5

## [11.0.23-1] - 2024-06-07
### Changed
- Upgrade to base image 3.19.1-2 (#22)
  - Contains doguctl v0.10.0
- Upgrade to OpenJDK 11.0.23 (#22)

## [11.0.20-1] - 2023-09-20
### Changed
- Upgrade to base image 3.18.3 (#22)
- Upgrade to OpenJDK 11.0.20 (#22)


## [11.0.19-1] - 2023-06-16
### Changed 
- Upgrade to OpenJDK 11.0.19 (#23)

## [11.0.18-1] - 2023-04-21
### Changed
- Upgrade to OpenJDK 11.0.18 (#16)
- Update base image to 3.17.3-2 (#17)

## [11.0.14-3] - 2022-04-04
### Changed
- Upgrade to base image 3.15.3-1

## [11.0.14-2] - 2022-03-29
### Changed
- Upgrade to base image 3.15.2-1 (#11)

## [11.0.14-1] - 2022-02-04
### Changed
- Upgrade to base image 3.14.3-1
- Upgrade to OpenJDK 11.0.14

## [11.0.11-2]
### Added
- Add support for additional certificates (#4)
   - see the [operations docs](docs/operations_en.md) for more information

## [11.0.11-1]
### Changed
- update to Oracle OpenJDK 11.0.11_p9-r0
- update base image to 3.14.2-1

## [11.0.5-4]
### Changed
- update base image to 3.11.6-3

## [11.0.5-3]
### Changed
- update base image to 3.11.6-2

## [11.0.5-2]
### Changed
- update base image to 3.11.6-1

## [11.0.5-1]
### Changed
- update to Oracle OpenJDK 11.0.5_p10-r0
- update base image to 3.11.5-1
