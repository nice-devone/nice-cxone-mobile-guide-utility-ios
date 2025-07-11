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

/// Log messages by printing them using `Swift.print`
public struct PrintLogWriter: LogWriter {

    // MARK: - Properties

    private let print: (String) -> Void

    // MARK: - Init

    public init(print: @escaping (String) -> Void = { Swift.print($0) }) {
        self.print = print
    }

    // MARK: - Methods

    /// Write a message to this log
    /// 
    /// - Parameter record: ``LogRecord`` to log
    public func log(record: LogRecord) {
        self.print(record.formatted)
    }
}
