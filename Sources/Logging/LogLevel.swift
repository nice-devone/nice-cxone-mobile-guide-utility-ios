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

/// Signficance or severity of a log message
public enum LogLevel: String, Sendable, CaseIterable, Equatable {
    /// detailed flow tracing
    case trace
    /// intended for logging detailed information about the system for debugging purposes.
    case debug
    /// includes messages that provide a record of the normal operation of the system.
    case info
    /// signifies potential issues that may lead to errors or unexpected behavior in the future if not addressed.
    case warning
    /// indicates error conditions that impair some operation but are less severe than critical situations.
    case error
    /// A critical unrecoverable error condition
    case fatal
}

// MARK: - LogLevel+CustomStringConvertible

extension LogLevel: CustomStringConvertible {
    /// Implement `CustomStringConvertible`
    public var description: String {
        rawValue.uppercased()
    }
}

// MARK: - LogLevel+Comparable

extension LogLevel: Comparable {
    
    public static func < (lhs: LogLevel, rhs: LogLevel) -> Bool {
        guard let lhs = allCases.firstIndex(of: lhs), let rhs = allCases.firstIndex(of: rhs) else {
            return false
        }

        return lhs < rhs
    }
}
