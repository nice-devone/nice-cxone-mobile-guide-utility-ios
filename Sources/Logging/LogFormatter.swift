//
// Copyright (c) 2021-2026. NICE Ltd. All rights reserved.
//
// Licensed under the NICE License;
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    https://github.com/nice-devone/nice-cxone-mobile-guide-utility-ios/blob/main/LICENSE
//
// TO THE EXTENT PERMITTED BY APPLICABLE LAW, THE CXONE MOBILE SDK IS PROVIDED ON
// AN "AS IS" BASIS. NICE HEREBY DISCLAIMS ALL WARRANTIES AND CONDITIONS, EXPRESS
// OR IMPLIED, INCLUDING (WITHOUT LIMITATION) WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE, NON-INFRINGEMENT, AND TITLE.
//

import Foundation

/// A function that formats log messages
public struct LogFormatter: Sendable {

    // MARK: - Properties

    /// `Sendable` format style used to render ``timeStamp``.
    ///
    /// Renders timestamps using the pattern `"HH:mm:ss:SSS dd.MM.yyyy"` via
    /// `Date.VerbatimFormatStyle`, which is thread-safe by design.
    ///
    /// Intentionally pins the Gregorian calendar instead of inheriting the user's
    /// auto-updating calendar (as a default `DateFormatter` would). This keeps log
    /// timestamps consistent across non-Gregorian locales (e.g. Buddhist, Japanese,
    /// Hebrew) where the year component would otherwise differ, at the cost of no
    /// longer being a strict drop-in replacement for the legacy `DateFormatter`
    /// pattern's defaults.
    private static let logDateStyle = Date.VerbatimFormatStyle(
        // swiftlint:disable:next line_length
        format: "\(hour: .twoDigits(clock: .twentyFourHour, hourCycle: .zeroBased)):\(minute: .twoDigits):\(second: .twoDigits):\(secondFraction: .fractional(3)) \(day: .twoDigits).\(month: .twoDigits).\(year: .padded(4))",
        timeZone: .current,
        calendar: Calendar(identifier: .gregorian)
    )

    /// Generate an internally consistent time stamp
    private static var timeStamp: String {
        Date.provided.formatted(logDateStyle)
    }

    /// Format log messages with just the level, category, and message
    ///
    /// ## Example
    /// ```json
    /// TRACE [CORE]: Foo
    /// ```
    public static let simple = Self { record in
        let category = record.category.map { "[\($0)]" } ?? ""

        return "\(record.level) \(category): \(record.message)"
    }

    /// Format log messages with level, category, message, and function name
    ///
    /// ## Example
    /// ```
    /// HH:mm:ss:SSS dd.MM.yyyy TRACE [CORE]: Foo
    /// ```
    public static let medium = Self { record in
        let category = record.category.map { "[\($0)]" } ?? ""

        return "\(timeStamp) \(record.level) \(category): \(record.message)"
    }

    /// Format log messages with level, category, message, function name, and file location
    ///
    /// ## Example
    /// ```
    /// HH:mm:ss:SSS dd.MM.yyyy TRACE [CORE] Manager:1: Foo
    /// ```
    public static let full = Self { record in
        let category = record.category.map { "[\($0)]" } ?? ""
        let location = "\(record.file.lastPathComponent):\(record.line)"

        return "\(timeStamp) \(record.level) \(category) \(location): \(record.message)"
    }

    /// Closure that takes a ``LogRecord`` and returns the formatted log string.
    let formatter: @Sendable (_ record: LogRecord) -> String

    // MARK: - Init

    /// Create a formatter from a `@Sendable` closure.
    /// - Parameter formatter: closure that transforms a ``LogRecord`` into a formatted string.
    public init(formatter: @escaping @Sendable (_ record: LogRecord) -> String) {
        self.formatter = formatter
    }

    // MARK: - Methods

    /// Format a message to be written to the logger.
    ///
    /// - Parameter record: message details to log
    /// - Returns: updated ``LogRecord`` to log
    func callAsFunction(record: LogRecord) -> LogRecord {
        record.copy(formatted: formatter(record))
    }
}
