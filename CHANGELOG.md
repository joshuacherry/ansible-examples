# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

| Change Type   | Description                            |
| :------------ | :------------------------------------- |
| Added         | for new features.                      |
| Changed       | for changes in existing functionality. |
| Deprecated    | for soon-to-be removed features.       |
| Removed       | for now removed features.              |
| Fixed         | for any bug fixes.                     |
| Security      | in case of vulnerabilities.            |

## [Unreleased]

## [0.3.0] - 2017-11-29

### Added

- [apache](https://github.com/joshuacherry/ansible-role-apache) role added to prometheus
- [dhparams](https://github.com/joshuacherry/ansible-role-dhparams) role added to prometheus
- [openssl](https://github.com/joshuacherry/ansible-role-openssl) role added to prometheus

### Changed

- Default playbook in `Makefile` changed to prometheus

### Fixed

- Explicitly set mount_options for Vagrant folder to fix script file permissions on Mac.

## [0.2.0] - 2017-11-10

### Fixed

- Updated .travis.yml to not use publickeys for submodule downloads

[Unreleased]: https://github.com/joshuacherry/ansible-examples/compare/0.3.0...HEAD
[0.3.0]: https://github.com/joshuacherry/ansible-examples/compare/0.2.0...0.3.0
[0.2.0]: https://github.com/joshuacherry/ansible-examples/compare/0.1.0...0.2.0