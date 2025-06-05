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

/// A record of the details to be logged. All details are maintained throughout the ``LogWriter`` chain to facilitate
/// customized formatting, filtering, and other operations in a fully isolated manner.
public struct LogRecord: Equatable {

    // MARK: - Properties

    /// raw message to log
    public let message: String
    /// `LogLevel`` of message to log
    public let level: LogLevel
    /// category of message to log
    public let category: String?
    /// originating file of log message
    public let file: StaticString
    /// originating line of log message
    public let line: UInt
    /// raw message to log
    public let formatted: String

    // MARK: - Init

    /// Full constructor
    ///
    /// - Parameters:
    ///     - message: raw message to log
    ///     - level ``LogLevel`` of message to log
    ///     - category: category of message to log
    ///     - file: originating file of log message
    ///     - line: originating line of log message
    ///     - formatted: fully formatted message to log
    public init(
        message: String,
        level: LogLevel,
        category: String?,
        file: StaticString,
        line: UInt,
        formatted: String? = nil
    ) {
        self.formatted = formatted ?? message
        self.message = message
        self.level = level
        self.category = category
        self.file = file
        self.line = line
    }

    // MARK: - Methods

    public func copy(
        message: String? = nil,
        level: LogLevel? = nil,
        category: String? = nil,
        file: StaticString? = nil,
        line: UInt? = nil,
        formatted: String? = nil
    ) -> Self {
        Self(
            message: message ?? self.message,
            level: level ?? self.level,
            category: category ?? self.category,
            file: file ?? self.file,
            line: line ?? self.line,
            formatted: formatted ?? self.formatted
        )
    }
}
