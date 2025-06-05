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

@testable import CXoneGuideUtility
import Foundation
import Testing

@Test func testDataWrite() throws {
    let data = Data.random(count: 64)

    let stream = OutputStream(toMemory: ())

    try stream.use { stream in
        stream.open()

        try stream.write(data)

        stream.close()
    }

    let written = stream.property(forKey: Stream.PropertyKey.dataWrittenToMemoryStreamKey) as? Data

    #expect(data == written)
}

@Test func testStringWrite() throws {
    let stream = OutputStream(toMemory: ())

    try stream.use { stream in
        stream.open()

        try stream.write("Hello World!\n")

        stream.close()
    }

    let written = stream.property(forKey: Stream.PropertyKey.dataWrittenToMemoryStreamKey) as? Data

    #expect("Hello World!\n".data(using: .utf8) == written)
}
