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

/// Simplified access to logging functionality via a default ``LogWriter`` and category.
///
/// Example usage:
///
///     enum Log: StaticLogger {
///         nonisolated(unsafe) static var instance: LogWriter = PrintLogWriter()
///         nonisolated(unsafe) static let category: String? = nil
///     }
///
/// Once that's done, messages can be logged via `instance` using simple static methods. If `category`
/// is specified, it will be used as a default category for all messages logged using the `StaticLogger`.
///
///     Log.trace("Reached checkpoint")
///
/// To log to both a file and the print console:
///
///     Log.instance = ForkLogWriter(
///         FileLogWriter("log"),
///         PrintLogWriter()
///     ).filter(minLevel: .warning)
///
/// ``ForkLogWriter`` and ``LogWriter.filter`` can also be combined to log different categories of messages
/// using different loggers:
///
///     Log.instance = ForkLogWriter(
///         FileLogWriter("log"),
///         SystemLogWriter().filter(categories: "CORE")
///     )
///
/// The format of logged messages can be set with the ``LogWriter.format`` function:
///
///     Log.instance = SystemLogWriter().format(.simple)
///
/// As with filter, different loggers can use different formats:
///
///     Log.instance = ForkLogWriter(
///         FileLogWriter("log").format(.full),
///         PrintLogWriter().format(.simple)
///     )
///
public protocol StaticLogger {
    /// ``LogWriter`` to which messages will be logged. If instance is nil
    /// no logging will occur.
    static var instance: LogWriter? { get }

    /// Default category for messages logged using this `StaticLogger` if
    /// no category is specified in the actual logging call.
    static var category: String? { get }
}

public extension StaticLogger {

    /// Write a message to this log
    ///
    /// - Parameters:
    ///     - message: message to log
    ///     - level: `LogLevel` for this message
    ///     - category: category with which to tag the message
    ///     - file: file where message was generated
    ///     - fun: function where message was generated
    ///     - line: line where message was generated
    static func log(
        _ message: String,
        level: LogLevel,
        category: String? = nil,
        file: StaticString = #file,
        line: UInt = #line
    ) {
        instance?.log(
            record: LogRecord(
                message: message,
                level: level,
                category: category ?? Self.category,
                file: file,
                line: line
            )
        )
    }

    /// Log a message at level ``LogLevel/trace``.
    ///
    /// - Parameters:
    ///   - message: message to log
    ///   - category: category with which to tag the message
    ///   - file: file of trace call
    ///   - line: line of trace call
    static func trace(
        _ message: String,
        category: String? = nil,
        file: StaticString = #file,
        line: UInt = #line
    ) {
        log(
            message,
            level: .trace,
            category: category,
            file: file,
            line: line
        )
    }

    /// Log a message at level ``LogLevel/debug``.
    ///
    /// - Parameters:
    ///   - message: message to log
    ///   - category: category with which to tag the message
    ///   - file: file of trace call
    ///   - line: line of trace call
    static func debug(
        _ message: String,
        category: String? = nil,
        file: StaticString = #file,
        line: UInt = #line
    ) {
        log(
            message,
            level: .debug,
            category: category,
            file: file,
            line: line
        )
    }

    /// Log a message at level ``LogLevel/info``.
    ///
    /// - Parameters:
    ///   - message: message to log
    ///   - category: category with which to tag the message
    ///   - file: file of trace call
    ///   - line: line of trace call
    static func info(
        _ message: String,
        category: String? = nil,
        file: StaticString = #file,
        line: UInt = #line
    ) {
        log(
            message,
            level: .info,
            category: category,
            file: file,
            line: line
        )
    }

    /// Log a message at level ``LogLevel/warning``.
    ///
    /// - Parameters:
    ///   - message: message to log
    ///   - category: category with which to tag the message
    ///   - file: file of trace call
    ///   - line: line of trace call
    static func warning(
        _ message: String,
        category: String? = nil,
        file: StaticString = #file,
        line: UInt = #line
    ) {
        log(
            message,
            level: .warning,
            category: category,
            file: file,
            line: line
        )
    }

    /// Log a message at level ``LogLevel/error``.
    ///
    /// - Parameters:
    ///   - message: message to log
    ///   - category: category with which to tag the message
    ///   - file: file of trace call
    ///   - line: line of trace call
    static func error(
        _ message: String,
        category: String? = nil,
        file: StaticString = #file,
        line: UInt = #line
    ) {
        log(
            message,
            level: .error,
            category: category,
            file: file,
            line: line
        )
    }

    /// Log a message at level ``LogLevel/fatal``.
    ///
    /// - Parameters:
    ///   - message: message to log
    ///   - category: category with which to tag the message
    ///   - file: file of trace call
    ///   - line: line of trace call
    static func fatal(
        _ message: String,
        category: String? = nil,
        file: StaticString = #file,
        line: UInt = #line
    ) {
        log(
            message,
            level: .fatal,
            category: category,
            file: file,
            line: line
        )
    }
    
    /// Execute and track entry/exit of a code block
    ///
    /// - Parameters:
    ///   - block: code block to execute and track
    ///   - scope: name of the scope (defaults to function name)
    ///   - file: file of scope call
    ///   - line: line of scope call
    /// - Returns: value returned by block
    @discardableResult
    static func scope<T>(
        _ block: () throws -> T,
        scope: StaticString = #function,
        file: StaticString = #file,
        line: UInt = #line
    ) rethrows -> T {
        trace("Enter \(scope)", file: file, line: line)
        
        defer {
            trace("Exit \(scope)", file: file, line: line)
        }
        
        return try block()
    }
    
    /// Execute, time, and track entry/exit of a code block
    /// 
    /// - Parameters:
    ///   - block: code block to execute and measure
    ///   - scope: name of the scope (defaults to function name)
    ///   - file: file of time call
    ///   - line: line of time call
    /// - Returns: value returned by block
    @discardableResult
    static func time<T>(
        _ block: () throws -> T,
        scope: StaticString = #function,
        file: StaticString = #file,
        line: UInt = #line
    ) rethrows -> T {
        let start = Date.provided.timeIntervalSince1970
        
        trace("Enter \(scope)", file: file, line: line)
        
        defer {
            let elapsed = Int(((Date.provided.timeIntervalSince1970 - start) * 1000).rounded())
            trace("Exit \(scope): \(elapsed)ms", file: file, line: line)
        }
        
        return try block()
    }
}
