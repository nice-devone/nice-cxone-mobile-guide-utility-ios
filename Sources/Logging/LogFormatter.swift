//
// Copyright (c) 2021-2025. NICE Ltd. All rights reserved.
//
// Licensed under the NICE License;
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    https://github.com/nice-devone/nice-cxone-mobile-guide-utility-ios/blob/main/LICENSE
//
// TO THE EXTENT PERMITTED BY APPLICABLE LAW, THE CXONE MOBILE SDK IS PROVIDED ON
// AN “AS IS” BASIS. NICE HEREBY DISCLAIMS ALL WARRANTIES AND CONDITIONS, EXPRESS
// OR IMPLIED, INCLUDING (WITHOUT LIMITATION) WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE, NON-INFRINGEMENT, AND TITLE.
//

import Foundation

/// A function that formats log messages
public struct LogFormatter {

    // MARK: - Properties

    /// Formatter instance used to format ``timeStamp``
    private static let logDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss:SSS dd.MM.yyyy"

        return formatter
    }()

    /// Generate an internally consistent time stamp
    private static var timeStamp: String {
        logDateFormatter.string(from: Date.provided)
    }

    /// Format log messages with just the level, category, and message
    ///
    /// ## Example
    /// ```json
    /// TRACE [CORE]: Foo
    /// ```
    nonisolated(unsafe) public static let simple = Self { record in
        let category = record.category.map { "[\($0)]" } ?? ""

        return "\(record.level) \(category): \(record.message)"
    }

    /// Format log messages with level, category, message, and function name
    ///
    /// ## Example
    /// ```
    /// HH:mm:ss:SSS dd.MM.yyyy TRACE [CORE]: Foo
    /// ```
    nonisolated(unsafe) public static let medium = Self { record in
        let category = record.category.map { "[\($0)]" } ?? ""

        return "\(timeStamp) \(record.level) \(category): \(record.message)"
    }

    /// Format log messages with level, category, message, function name, and file location
    ///
    /// ## Example
    /// ```
    /// HH:mm:ss:SSS dd.MM.yyyy TRACE [CORE] Manager:1: Foo
    /// ```
    nonisolated(unsafe) public static let full = Self { record in
        let category = record.category.map { "[\($0)]" } ?? ""
        let location = "\(record.file.lastPathComponent):\(record.line)"

        return "\(timeStamp) \(record.level) \(category) \(location): \(record.message)"
    }

    let formatter: (_ record: LogRecord) -> String

    // MARK: - Methods

    /// Format a message to be written to the logger.
    ///
    /// - Parameter record: message details to log
    /// - Returns: updated ``LogRecord`` to log
    func callAsFunction(record: LogRecord) -> LogRecord {
        record.copy(formatted: formatter(record))
    }
}
