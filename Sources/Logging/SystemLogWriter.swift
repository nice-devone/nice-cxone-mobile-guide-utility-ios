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
import os

/// Log messages to `os.Logger`
public struct SystemLogWriter: LogWriter {
    
    // MARK: - Properties

    /// Target `Logger` to utilize when logging messages.
    private let logger: Logger

    // MARK: - Init

    /// Create a ``LogWriter`` to log messages to a system logger.
    ///
    /// - Parameter logger: target ``Logger`` for all messages.
    public init(logger: Logger = Logger()) {
        self.logger = logger
    }

    // MARK: - Methods

    /// Write a message to all child logs
    /// 
    /// - Parameter record: ``LogRecord`` to log
    public func log(record: LogRecord) {
        switch record.level {
        case .debug:
            logger.debug("\(record.formatted, privacy: .public)")

        case .trace:
            logger.trace("\(record.formatted, privacy: .public)")

        case .info:
            logger.info("\(record.formatted, privacy: .public)")

        case .warning:
            logger.warning("\(record.formatted, privacy: .public)")

        case .error:
            logger.error("\(record.formatted, privacy: .public)")

        case .fatal:
            logger.critical("\(record.formatted, privacy: .public)")
        }
    }
}
