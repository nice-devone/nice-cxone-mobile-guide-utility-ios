//
// Copyright (c) 2021-2026. NICE Ltd. All rights reserved.
//
// Licensed under the NICE License;
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    https://github.com/nice-devone/nice-cxone-mobile-guide-utility-ios/blob/main/LICENSE
//
// TO THE EXTENT PERMITTED BY APPLICABLE LAW, THE CXONE MOBILE SDK IS PROVIDED ON
// AN "AS IS" BASIS. NICE HEREBY DISCLAIMS ALL WARRANTIES AND CONDITIONS, EXPRESS
// OR IMPLIED, INCLUDING (WITHOUT LIMITATION) WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE, NON-INFRINGEMENT, AND TITLE.
//

import Foundation
import os

/// Thread-safe container for mutable `Sendable` state shared across concurrent contexts.
///
/// `SafeAccessContainer` wraps a value of type `T` behind an `OSAllocatedUnfairLock`,
/// giving callers a `Sendable` reference type that can be passed across actor boundaries
/// without resorting to `@unchecked Sendable`. The lock guarantees mutually exclusive
/// access to the wrapped value; combined with the `T: Sendable` constraint, this rules
/// out data races at the type-system level.
///
/// ## Read vs. read-modify-write
///
/// Use ``content`` for a one-shot read. Use ``mutate(_:)`` for any sequence that needs
/// to observe the current value *and* write back a new one — the closure executes inside
/// a single lock acquisition, eliminating the TOCTOU race that would otherwise arise
/// from interleaving a `content` get and a subsequent write.
///
/// ```swift
/// // ❌ Race: another thread can mutate between the read and the write.
/// var copy = container.content
/// copy.append(value)
/// container.mutate { $0 = copy }       // last writer wins, intermediate updates lost
///
/// // ✅ Atomic: the read and write happen under one lock acquisition.
/// container.mutate { state in
///     state.append(value)
/// }
/// ```
///
/// The closure passed to ``mutate(_:)`` is held under the lock, so it must not call
/// `await` or block on another lock that could itself be waiting on this one.
///
/// ## Choosing between this and an actor
///
/// Reach for ``SafeAccessContainer`` when you need synchronous, fast access to a single
/// piece of mutable state from arbitrary concurrent contexts (e.g. a counter, a
/// configuration snapshot, a delegate weak-reference table). Prefer an `actor` when you
/// need to coordinate multiple related pieces of state or when the work that mutates
/// the state itself wants to `await`.
public final class SafeAccessContainer<T: Sendable>: Sendable {

    // MARK: - Properties

    private let storage: OSAllocatedUnfairLock<T>

    // MARK: - Init

    /// Creates a container holding `initialValue` behind a fresh lock.
    ///
    /// - Parameter initialValue: The starting value of the wrapped state.
    public init(_ initialValue: T) {
        self.storage = OSAllocatedUnfairLock(initialState: initialValue)
    }

    // MARK: - Access

    /// A snapshot of the wrapped value taken under the lock.
    ///
    /// Each access copies the current value out of the lock; do not use this property
    /// for read-modify-write sequences — use ``mutate(_:)`` instead.
    public var content: T {
        storage.withLock { value in
            value
        }
    }

    /// Atomically reads, modifies, and (optionally) writes back the wrapped value.
    ///
    /// The closure runs while the lock is held, so the value it sees and the value it
    /// returns are observed by no other thread in between. This eliminates the TOCTOU
    /// race that arises when callers do
    /// `var tmp = container.content; tmp.mutate(); container.content = tmp`.
    ///
    /// - Parameter body: A closure that receives the current value `inout` and may
    ///   modify it. Anything it returns is forwarded back to the caller.
    /// - Returns: Whatever `body` returns.
    /// - Important: The closure runs under a non-recursive lock — do not call back into
    ///   this container (or `await`) from within it, or you will deadlock.
    @discardableResult
    public func mutate<R: Sendable>(_ body: @Sendable (inout T) throws -> R) rethrows -> R {
        try storage.withLock { value in
            try body(&value)
        }
    }
}
