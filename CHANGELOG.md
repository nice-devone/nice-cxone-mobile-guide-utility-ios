<a name="Unreleased"></a>
# [Unreleased]


<a name="4.0.0"></a>
# [4.0.0] - 2026-08-05

## Breaking Changes
- Raised `swift-tools-version` from 5.7 to 6.0 (requires Xcode 16 or later)
- Increase minimum iOS deployment target to 16.0 and minimum macOS to 13.0
- Adopt Swift strict-concurrency: `LogWriter` now requires `Sendable` conformance — custom writer implementations must be `Sendable`
- `ForkLogWriter` is now `final`

## Features
- `LogFormatter` now conforms to `Sendable`


<a name="3.3.1"></a>
# [3.3.1] - 2026-06-24

## Changed

- Version bump to 3.3.1


<a name="3.3.0"></a>
# [3.3.0] - 2026-05-07

## Changed

- Version bump to 3.3.0


<a name="3.2.0"></a>
# [3.2.0] - 2026-02-26

## Features
- add NOTICE.md
- raise the supported macOS version to v12


<a name="3.1.0"></a>
# [3.1.0] - 2025-11-18

## Features
- Update formatting
- Update tests


<a name="3.0.1"></a>
# [3.0.1] - 2025-07-11

## Features
- Update time format for logDateFormatter

## Fixes
- Correct URL in header
- Fix Unit tests


<a name="3.0.0"></a>
# [3.0.0] - 2025-06-04

## Features
- Release the module


[Unreleased]: https://github.com/nice-devone/nice-cxone-mobile-guide-utility-ios/compare/4.0.0...HEAD
[4.0.0]: https://github.com/nice-devone/nice-cxone-mobile-guide-utility-ios/compare/3.3.1...4.0.0
[3.3.1]: https://github.com/nice-devone/nice-cxone-mobile-guide-utility-ios/compare/3.3.0...3.3.1
[3.3.0]: https://github.com/nice-devone/nice-cxone-mobile-guide-utility-ios/compare/3.2.0...3.3.0
[3.2.0]: https://github.com/nice-devone/nice-cxone-mobile-guide-utility-ios/compare/3.1.0...3.2.0
[3.1.0]: https://github.com/nice-devone/nice-cxone-mobile-guide-utility-ios/compare/3.0.1...3.1.0
[3.0.1]: https://github.com/nice-devone/nice-cxone-mobile-guide-utility-ios/compare/3.0.0...3.0.1
