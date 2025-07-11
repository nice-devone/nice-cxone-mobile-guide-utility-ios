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

struct LogFilterTests {
    @Test(arguments: LogLevel.allCases, LogLevel.allCases)
    func filterByLevel(level: LogLevel, target: LogLevel) async throws {
        let mock = MockLogWriter(policy: .relaxed)
        let writer = mock.filter(level: target)
        let record = LogRecord(
            message: "Message",
            level: level,
            category: nil,
            file: #file,
            line: #line
        )

        writer.log(record: record)

        verify(mock)
            .log(record: .value(record))
            .called(level >= target ? 1 : 0)
    }

    @Test(arguments: ["Test", "Other"], ["Test", "Other"])
    func filterByCategory(category: String, target: String) async throws {
        let mock = MockLogWriter(policy: .relaxed)
        let writer = mock.filter(categories: target)
        let record = LogRecord(
            message: "Message",
            level: .debug,
            category: category,
            file: #file,
            line: #line
        )

        writer.log(record: record)

        verify(mock)
            .log(record: .value(record))
            .called(category == target ? 1 : 0)
    }
}
