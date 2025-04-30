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

public extension LogWriter {
    /// Attach a formatter to the receiving ``LogWriter``
    ///
    /// - Parameter formatter: ``LogFormatter`` to use formatting messages
    /// to the receiver.
    func format(_ formatter: LogFormatter) -> LogWriter {
        LogFormatterWriter(writer: self, formatter: formatter)
    }

    /// Attach a formatting function to the receiving ``LogWriter``
    /// - Parameter formatter: function to use formatting messages
    /// to the receiver.
    func format(_ formatter: @escaping (LogRecord) -> String) -> LogWriter {
        format(LogFormatter(formatter: formatter))
    }
}

// MARK: - LogFormatterWriter

/// A ``LogWriter`` that formats the message before passing it on
private struct LogFormatterWriter: LogWriter {

    // MARK: - Properties

    /// Target ``LogWriter``
    let writer: LogWriter
    /// ``LogFormatter`` to use for message formatting
    let formatter: LogFormatter

    // MARK: - Methods

    /// Implement ``LogWriter.log(record:)``
    /// 
    /// - Parameter record: message details to record``
    func log(record: LogRecord) {
        writer.log(record: formatter(record: record))
    }
}
