//
// Copyright (c) 2021-2025. NICE Ltd. All rights reserved.
//
// Licensed under the NICE License;
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    https://github.com/nice-devone/nice-cxone-mobile-utility/blob/main/LICENSE
//
// TO THE EXTENT PERMITTED BY APPLICABLE LAW, THE CXONE MOBILE SDK IS PROVIDED ON
// AN “AS IS” BASIS. NICE HEREBY DISCLAIMS ALL WARRANTIES AND CONDITIONS, EXPRESS
// OR IMPLIED, INCLUDING (WITHOUT LIMITATION) WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE, NON-INFRINGEMENT, AND TITLE.
//

import Foundation

/// A ``LogWriter`` that filters messages to be output based on a predicate.
///
/// Most easily used via `LogWriter.filter`:
///
///     let writer = FileLogWriter(url: URL).filter(level: .warning)
public struct LogFilter: LogWriter {
    public typealias Predicate = (LogRecord) -> Bool

    // MARK: - Properties

    /// predicate filter to be applied to every message to send. Only if `predicate` returns true
    ///     will the message be written via `writer`.
    let predicate: Predicate

    /// underlying writer to use. Messages matching `predicate` will be output using `writer`
    let writer: LogWriter

    // MARK: - Init

    public func log(record: LogRecord) {
        if predicate(record) {
            writer.log(record: record)
        }
    }
}

// MARK: - LogWriter+LogFilter

public extension LogWriter {
    
    /// Apply a filter to a ``LogWriter``. The receiver `LogWriter` will only log messages that match `predicate`
    /// - Parameter predicate: Predicate to match.
    func filter(
        _ predicate: @escaping LogFilter.Predicate
    ) -> LogWriter {
        LogFilter(predicate: predicate, writer: self)
    }

    /// Apply a filter to a ``LogWriter``. The receiver `LogWriter` will only log messages with a level >= `level`
    /// - Parameter minLevel: Minimum `LogLevel` to log
    func filter(level minLevel: LogLevel) -> LogWriter {
        filter { record in
            record.level >= minLevel
        }
    }

    /// Apply a filter to a ``LogWriter`` based on only passing messages in a list of categories.
    /// - Parameter categories: list of categories to be logged
    func filter(categories: String...) -> LogWriter {
        filter { record in
            record.category.map(categories.contains) ?? false
        }
    }
}
