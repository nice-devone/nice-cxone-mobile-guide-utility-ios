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

/// Log messages by logging them to each of the child ``LogWriter``s.
public class ForkLogWriter: LogWriter {

    // MARK: - Properties

    private let loggers: [any LogWriter]

    // MARK: - Init

    /// Create a new ProxyLogWriter to forward messages to a given list of ``LogWriter``
    /// 
    /// - Parameter loggers: vararg list of LogWriters to target
    public init(_ loggers: any LogWriter...) {
        self.loggers = loggers
    }

    /// Create a new ProxyLogWriter to forward messages to a given ``[LogWriter]``
    ///
    /// - Parameter loggers: vararg list of LogWriters to target
    public init(loggers: [any LogWriter]) {
        self.loggers = loggers
    }

    // MARK: - Methods

    /// Write a message to all child logs
    ///
    /// - Parameter record: ``LogRecord`` to log
    public func log(record: LogRecord) {
        loggers.forEach { logger in
            logger.log(record: record)
        }
    }
}
