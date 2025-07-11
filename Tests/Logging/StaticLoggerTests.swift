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

import CXoneGuideUtility
import Mockable
import Testing

private enum Log: StaticLogger {
    nonisolated(unsafe) static var instance: LogWriter?
    nonisolated(unsafe) static var category: String?
}

class StaticLoggerTests {
    private let logger = MockLogWriter(policy: .relaxed)
    private let category = "Test"
    private let file: StaticString = #file
    private let line: UInt = #line
    private let message = "Hello, world!"

    init() {
        print("init")
        Log.instance = logger
        Log.category = category
    }

    deinit {
        Log.instance = nil
        Log.category = nil
    }

    @Test func trace() {
        Log.trace(message, file: file, line: line)

        verify(logger)
            .log(record: .value(
                LogRecord(
                    message: message,
                    level: .trace,
                    category: category,
                    file: file,
                    line: line,
                    formatted: message
                )
            ))
            .called(1)
    }

    @Test func debug() {
        Log.debug(message, file: file, line: line)

        verify(logger)
            .log(record: .value(
                LogRecord(
                    message: message,
                    level: .debug,
                    category: category,
                    file: file,
                    line: line,
                    formatted: message
                )
            ))
            .called(1)
    }

    @Test func info() {
        Log.info(message, file: file, line: line)

        verify(logger)
            .log(record: .value(
                LogRecord(
                    message: message,
                    level: .info,
                    category: category,
                    file: file,
                    line: line,
                    formatted: message
                )
            ))
            .called(1)
    }

    @Test func warning() {
        Log.warning(message, file: file, line: line)

        verify(logger)
            .log(record: .value(
                LogRecord(
                    message: message,
                    level: .warning,
                    category: category,
                    file: file,
                    line: line,
                    formatted: message
                )
            ))
            .called(1)
    }

    @Test func error() {
        Log.error(message, file: file, line: line)

        verify(logger)
            .log(record: .value(
                LogRecord(
                    message: message,
                    level: .error,
                    category: category,
                    file: file,
                    line: line,
                    formatted: message
                )
            ))
            .called(1)
    }

    @Test func fatal() {
        Log.fatal(message, file: file, line: line)

        verify(logger)
            .log(record: .value(
                LogRecord(
                    message: message,
                    level: .fatal,
                    category: category,
                    file: file,
                    line: line,
                    formatted: message
                )
            ))
            .called(1)
    }
}
