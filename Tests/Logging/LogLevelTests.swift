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

import CXoneGuideUtility
import Testing

struct LogLevelTests {

    @Test(
        arguments: zip(LogLevel.allCases, ["TRACE", "DEBUG", "INFO", "WARNING", "ERROR", "FATAL"])
    )
    func testDescription(level: LogLevel, label: String) {
        #expect(level.description == label)
    }

    @Test(arguments: LogLevel.allCases, LogLevel.allCases)
    func testComparison(left: LogLevel, right: LogLevel) {
        #expect(
            (left < right) == (LogLevel.allCases.firstIndex(of: left)! < LogLevel.allCases.firstIndex(of: right)!)
        )
    }
}
