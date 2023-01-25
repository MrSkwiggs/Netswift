# Change Log

All notable changes to this project will be documented in this file

## [0.6.2 (20220826)]

### Changed

- Made variables under `NetswiftNetworkPerformer` & `NetswiftHTTPPerformer` public

## [0.6.0 (20211213)]

### Added

- Netswift now supports `Async/Await`, implemented by @Deco354
- **[BREAKING]** NetswiftRequestPerformable now has an additional requirement so that they can be performed with a time-out.
- `NetswiftHTTPMethod.head`, a convenience accessor for `HEAD` http methods.
- `NetswiftRequest.curl`, a convenience `cURL` string generator for any request.

### Changed

- Made variables & constructor under `NetswiftHTTPResponse` public.

## [0.5.1 (202108201]

### Changed

- Marked `NetswiftRequest.body(_:)` as `throws -> Data?`

## [0.5.0 (20210820)]

### Added

- New `NetswiftEncoder` wrapper protocol for types such as `JSONEncoder` or `PropertyListEncoder` (those 2 are already made to conform to `NetswiftEncoder`)

### Changed

- `NetswiftRequest` now has new requirements:
  - A `bodyEncoder: NetswiftEncoder?` var, which can be used to encode any data into the request's `httpBody`;
  - A `body(encodedBy encoder: NetswiftEncoder?) -> Data?` function that uses the given encoder to return `Data?`, if applicable.

## [0.4.0]

### Changed

- HTTP Status Codes are now included in `NetswiftError.Category`

## [0.3.1 (20200824)]

### Changed

- `NetswiftError.Category` now conforms to `CustomDebugStringConvertible`

## [0.3.0 (20200225)]

### Changed

- `NetswiftError` has been refactored to always keep track of a network task's response payload, if any is available.
- `NetswiftRequest` are now given a chance to intercept and handle a `NetswiftError` when performed.

### Fixed

- Access control levels for `NetswiftHTTPPerformer` and `NetswiftPerformer` have been set to `open` to allow for overriding and extending.

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
