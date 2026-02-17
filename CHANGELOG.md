# Jenkins Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [8.452.09-4] - 2026-02-17
### Fixed
- [#91] Upgrade base-image to 3.23.3-4
  - This fixes a bug in doguctl, to not check the local config if volume is not mounted.

## [8.452.09-3] - 2026-02-12
### Security
- [#91] Upgrade base-image to 3.23.3-3
    - [#91] Update doguctl to v0.15.0 to fix [CVE-2025-61732](https://avd.aquasec.com/nvd/2026/CVE-2025-61732) and [CVE-2025-68121](https://avd.aquasec.com/nvd/2026/CVE-2025-68121).

## [8.452.09-2] - 2025-12-10
### Changed
- Upgrade base-image to 3.23.0-1

## [8.452.09-1] - 2025-12-02
### Changed
- Upgrade base-image to 3.22.0-5
- Upgrade Java to 8.452.09

## [8u432-1] - 2025-01-02
### Changed
- [#75] Upgrade base image to 3.21.0-1
- [#75] Upgrade java to 8.432.06-r0

### Security
- [#75] Fixes CVE-2024-45337

## [8u402-6] - 2024-09-18
### Changed
- Relicense to AGPL-3.0-only

## [8u402-5] - 2024-09-17
### Changed
- [#56] Update Base Image to v3.20.3-1

## [8u402-4] - 2024-08-06
### Changed
- [#48] Update Base Image to v3.20.2-1

### Security
- this release closes CVE-2024-41110

## [8u402-3] - 2024-06-26
### Changed
- [#43] Update Base Image to v3.20.1-2

### Security
- this release closes the following CVEs
    - CVE-2024-24788
    - CVE-2024-24789
    - CVE-2024-24790

## [8u402-2] - 2024-06-25
### Changed
- Upgrade to base image 3.20.1-1 (#41)
    - Contains doguctl v0.11.0
- Update makefiles to 9.0.5

## [8u402-1] - 2024-06-07
### Changed
- Upgrade to base image 3.19.1-2 (#36)
  - Contains doguctl v0.10.0
- Upgrade to OpenJDK 8.402.06-r0

## [8u392-1] - 2024-02-23
### Changed
- Upgrade to OpenJDK 8.392.08-r1

## [8u372-1] - 2023-09-20
### Changed
- Upgrade to base image 3.18.3-1 (#22)
- Upgrade to OpenJDK 8.372-07-r0 (#22)

## [8u362-1] - 2023-04-21
### Changed
- Upgrade to base image 3.17.3-2
- Upgrade to OpenJDK 8.362.09-r1

## [8u302-3] - 2022-05-11
### Added
- apk update and upgrade to Dockerfile

## [8u302-2] - 2022-05-11
### Changed
- Upgrade to base image 3.15.3-1
- Upgrade to OpenJDK 8.302.08-r2

## [8u302-1] - 2022-02-04
### Changed
- Upgrade to base image 3.14.3-1
- Upgrade to OpenJDK 8.302.08-r1

## [8u282-1]
### Added
- Add support for additional certificates (#4)
   - see the [operations docs](docs/operations_en.md) for more information
- Update base image to 3.14.2-2
- Update to OpenJDK 8.282.08-r1

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

## [8u252-3]
### Changed
- update to Oracle OpenJDK 8.252.09-r0
- update base image to 3.11.6-3

## [8u242-3]
### Changed
- update base image to 3.11.6-2

## [8u242-2]
- update to Oracle OpenJDK

### Changed
- update base image to 3.11.6-1

## [8u242-2]
### Changed
- update to Oracle OpenJDK 8.242.08-r0

