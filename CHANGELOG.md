# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.1.0] - 2026-08-27

### Changed

- Migrated the private DNS A record to the AzureRM v5 `private_dns_zone_id` argument.
- Raised the minimum AzureRM provider version to `5.0.0`.

## [1.0.1] - 2024-03-13

### Fixed

- Upgraded the Private Endpoint module version to allow null `private_dns_zone_group`

## [1.0.0] - 2024-01-08

### Added

- Initial Release to open source
