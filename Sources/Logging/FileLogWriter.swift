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

/// ``LogWriter`` that logs messages by appending them to a file
public struct FileLogWriter: LogWriter {

    // MARK: - Properties

    /// File path to write messages
    let path: URL

    // MARK: - Init

    /// Construct a new `FileLogWriter` to log to ``path``.
    ///
    /// - Parameter path: file path for logging
    public init(path: URL) {
        assert(path.isFileURL)

        self.path = path
    }

    // MARK: - Methods

    /// Implement ``LogWriter.log(record:)``
    ///
    /// - Parameter record: message details to record``
    public func log(record: LogRecord) {
        Task { @MainActor in
            try? OutputStream(url: path, append: true)?.use { stream in
                do {
                    try stream.write(record.formatted).write("\n\r")
                } catch {
                    print("An error occured writing to url: \(path)")
                }
            }
        }
    }
}
