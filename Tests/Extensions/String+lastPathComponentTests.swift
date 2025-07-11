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

@testable import CXoneGuideUtility
import Foundation
import Testing

struct StringLastPathComponentTests {

    @Test func emptyString() {
        #expect(StaticString(stringLiteral: "").lastPathComponent == "")
    }

    @Test func trailingSlash() {
        #expect(StaticString(stringLiteral: "/a/").lastPathComponent == "a")
    }

    @Test func singleComponent() {
        #expect(StaticString(stringLiteral: "a").lastPathComponent == "a")
    }

    @Test func multipleComponents() {
        #expect(StaticString(stringLiteral: "a/b/c").lastPathComponent == "c")
    }

}
