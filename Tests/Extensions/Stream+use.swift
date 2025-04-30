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
import Foundation
import Testing

private class MockOutputStream: OutputStream {
    var opens = 0
    var closes = 0
    var isOpen = false

    override func open() {
        opens += 1
        isOpen = true
    }

    override func close() {
        closes += 1
        isOpen = false
    }
}

private class MockInputStream: InputStream {
    var opens = 0
    var closes = 0
    var isOpen = false

    override func open() {
        opens += 1
        isOpen = true
    }

    override func close() {
        closes += 1
        isOpen = false
    }
}

@Test func outputStreamUseOpensAndCloses() throws {
    let expect = MockOutputStream()
    #expect(expect.opens == 0)
    #expect(expect.closes == 0)

    try expect.use { stream in
        #expect(expect === stream)
        #expect(stream.isOpen)
    }
    expect.close()
    
    #expect(expect.opens == 1)
    #expect(expect.closes == 1)
    #expect(expect.isOpen == false)
}

@Test func inputStreamUseOpensAndCloses() throws {
    let expect = MockInputStream()
    #expect(expect.opens == 0)
    #expect(expect.closes == 0)

    try expect.use { stream in
        #expect(expect === stream)
        #expect(stream.isOpen)
    }
    expect.close()
    
    #expect(expect.opens == 1)
    #expect(expect.closes == 1)
    #expect(expect.isOpen == false)
}
