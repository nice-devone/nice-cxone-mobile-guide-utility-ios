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

struct LogFormatterTests {
    @Test func formatExtensionApplies() {
        let mock = MockLogWriter(policy: .relaxed)
        let formatted = "Some Formatted Text"
        let writer = mock.format { _ in formatted }
        let record = LogRecord(
            message: "Message",
            level: .debug,
            category: nil,
            file: #file,
            line: #line
        )

        writer.log(record: record)

        verify(mock)
            .log(record: .value(record.copy(formatted: formatted)))
            .called(1)
    }
}
