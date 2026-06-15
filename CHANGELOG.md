# Jenkins Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [17.0.19-1] - 2026-06-15
### Changed
- Upgrade OpenJDK to v17.0.19
- Upgrade base-image to v3.24.0-1

## [17.0.18-7] - 2026-04-22
### Changed
- Upgrade base-image to v3.23.4-1

## [17.0.18-6] - 2026-03-25
### Changed
- Upgrade base-image to v3.23.3-6

## [17.0.18-5] - 2026-03-10
### Changed
- Upgrade base-image to v3.23.3-5

## [17.0.18-4] - 2026-02-17
### Fixed
- [#91] Upgrade base-image to 3.23.3-4
  - This fixes a bug in doguctl, to not check the local config if volume is not mounted.

## [17.0.18-3] - 2026-02-12
### Security
- [#91] Upgrade base-image to 3.23.3-3
    - [#91] Update doguctl to v0.15.0 to fix [CVE-2025-61732](https://avd.aquasec.com/nvd/2026/CVE-2025-61732) and [CVE-2025-68121](https://avd.aquasec.com/nvd/2026/CVE-2025-68121).

## [17.0.18-2] - 2026-02-09
### Changed
- [#88] Upgrade base-image to 3.23.3-2

## [17.0.18-1] - 2026-02-02
### Changed
- Upgrade base-image to 3.23.3-1
- Upgrade Java to 17.0.18_p8-r0

## [17.0.17-2] - 2025-12-10
### Changed
- Upgrade base-image to 3.23.0-1

## [17.0.17-1] - 2025-12-02
### Changed
- Upgrade base-image to 3.22.0-5
- Upgrade Java to 17.0.17

## [17.0.13-1] - 2025-01-02
### Changed
- [#75] Upgrade base image to 3.21.0-1
- [#75] Upgrade java to 17.0.13_p11-r0

### Security
- [#75] Fixes CVE-2024-45337

## [17.0.12-4] - 2024-10-22
### Changed
- [#72] Upgrade base-image to v3.20.3-3

## [17.0.12-3] - 2024-09-18
### Changed
- Relicense to AGPL-3.0-only

## [17.0.12-2] - 2024-09-17
### Changed
- [#60] Upgrade base-image to v3.20.3-1

## [17.0.12-1] - 2024-08-06
### Changed
- [#50] Upgrade base-image to v3.20.2-1
- [#50] Upgrade OpenJDK to 17.0.12

### Security
- this release closes CVE-2024-41110

## [17.0.11-3] - 2024-06-26
### Changed
- [#43] Update Base Image to v3.20.1-2

### Security
- this release closes the following CVEs
    - CVE-2024-24788
    - CVE-2024-24789
    - CVE-2024-24790

## [17.0.11-2] - 2024-06-25
- Upgrade to base image 3.19.1-2 (#41)
    - Contains doguctl v0.11.0
- Update makefiles to 9.0.5

## [17.0.11-1] - 2024-06-07
- Upgrade to base image 3.19.1-2 (#36)
  - Contains doguctl v0.10.0
- Upgrade to OpenJDK 17.0.11 (#36)

## [17.0.10-1] - 2024-04-18
### Changed
- Upgrade to base image 3.18.6-1
- Upgrade to OpenJDK 17.0.10

## [17.0.9-1] - 2023-11-10
### Changed
- Upgrade to OpenJDK 17.0.9

## [17.0.8-1] - 2023-09-21
### Changed
- Upgrade to base image 3.18.3-1
- Upgrade to OpenJDK 17.0.8

## [17.0.6-2] - 2023-04-21
### Changed
- Upgrade to base image 3.17.3-2

## [17.0.6-1] - 2023-03-10
### Changed
- Upgrade to base image 3.17.1-1
- Upgrade to OpenJDK 17.0.6

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
