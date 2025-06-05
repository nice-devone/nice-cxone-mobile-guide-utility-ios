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

/// Add-on protocol noting a class that can provide default values, primarily for testing.
protocol Provided {
    /// Current function to provide the next instance of `Self`
    nonisolated(unsafe) static var provider: () -> Self { get set }

    /// Return the current provided value
    nonisolated(unsafe) static var provided: Self { get }
}

extension Provided {
    /// Return the current provided value
    nonisolated(unsafe) static var provided: Self {
        provider()
    }
}

/// A function that provides the current Date.
///
/// Primarily useful for testing.
extension Date: Provided {
    /// Current provider of Date. Defaults to `Date()`
    nonisolated(unsafe) static var provider = {
        Date()
    }
}

extension UUID: Provided {
    nonisolated(unsafe) static var provider = {
        UUID()
    }
}
