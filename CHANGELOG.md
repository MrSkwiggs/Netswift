
# Change Log
All notable changes to this project will  be documented in this file

## [0.3.1 (20200824)]
### Changed
- `NetswiftError.Category` now conforms to `CustomDebugStringConvertible`

## [0.3.0 (20200225)]
### Changed
- `NetswiftError` has been refactored to always keep track of a network task's response payload, if any is available.
- `NetswiftRequest` are now given a chance to intercept and handle a `NetswiftError` when performed.

### Fixed
- Access control levels for  `NetswiftHTTPPerformer` and `NetswiftPerformer` have been set to `open` to allow for overriding and extending.

## [0.2.1 (20200209)]
### Added
- New Changelog file to keep track of updates!
- JPEG Mime Type
- `NetswiftError` now conforms to `Equatable`

### Changed
- Updated Readme to remove some deprecated stuff
- Renamed `MimeType.plainText` to `MimeType.text`

### Fixed
- Access control for several classes has been made public
- Fixed a typo for the `.mailto` Generic Scheme's rawValue
- Added missing headers in default implementation of `NetswiftRequest.serialise()`

## [0.2.0 (20200117)]
### Changed
- Use default SPM Platform requirements

