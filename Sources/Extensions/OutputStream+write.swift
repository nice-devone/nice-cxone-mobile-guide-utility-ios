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

extension OutputStream {

    // MARK: - Sub objects

    enum StreamError: Error {
        /// An error occured when converting a string to UTF8 to write to a file
        case invalidStringConversion
        /// An unknown error occured while writing a file
        case unknownError
    }

    // MARK: - Methods

    /// write Data to a file
    ///
    /// - Parameter data: `Data` to write to file
    /// - Returns receiver
    /// - Throws Can throw any Error that `OutputStream.write(_:_)` can throw
    @discardableResult
    func write(_ data: Data) throws -> Self {
        try data.withUnsafeBytes { rawBuffer in
            var buffer = rawBuffer.bindMemory(to: UInt8.self)

            while !buffer.isEmpty {
                // swiftlint:disable:next force_unwrapping
                let written = self.write(buffer.baseAddress!, maxLength: buffer.count)
                
                guard written >= 0 else {
                    throw self.streamError ?? StreamError.unknownError
                }
                
                buffer = UnsafeBufferPointer(rebasing: buffer.dropFirst(written))
            }
        }

        return self
    }

    /// write String to a file
    ///
    /// - Parameters:
    ///     - string: `String` to convert and write to file
    ///     - encoding: `String.Encoding` to use
    ///     - allowLossy: true to allow lossy conversion
    /// - Returns receiver
    /// - Throws Can throw any `Error` that `OutputStream.write` can throw
    /// - Throws `StreamError.invalidStringConversion` if `string` cannot be converted using the encoding `using`.
    @discardableResult
    func write(
        _ string: String,
        using encoding: String.Encoding = .utf8,
        allowLossyConversion allowLossy: Bool = true
    ) throws -> Self {
        guard let data = string.data(using: encoding, allowLossyConversion: allowLossy) else {
            throw StreamError.invalidStringConversion
        }

        return try write(data)
    }

    /// Write `Encodable` data to an `OutputStream`
    /// 
    /// - Parameters
    ///     - value: Value to be written
    ///     - encoder: `JSONEncoder` to be used for encoding. A default encoder is used if none is provided.
    /// - Returns: receiver
    /// - Throws: Can thrown any `Error` that `OutputStream.write` or `JSONEncoder.encode` can throw.
    func write<T: Encodable>(
        _ value: T,
        encoder: JSONEncoder = JSONEncoder()
    ) throws -> Self {
        let data = try encoder.encode(value)
        
        return try write(data)
    }
}
