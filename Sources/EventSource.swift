//
// EventSource.swift
// Eventitic
//
// Copyright (c) 2016 Hironori Ichimiya <hiron@hironytic.com>
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

import Foundation

private class UnlistenPool<T> {
    var listeners: [Listener<T>] = []
}

///
/// This class represents a source of events.
///
public class EventSource<T> {
    private var listeners: [Listener<T>]
    private var unlistenPools: [UnlistenPool<T>]

    ///
    /// Initializes an event source.
    ///
    public init() {
        listeners = []
        unlistenPools = []
    }
    
    ///
    /// Begins listening to events.
    ///
    /// - Parameter handler: A closure which handles events.
    /// - Returns: A listener object.
    ///
    public func listen(_ handler: @escaping (T) -> Void) -> Listener<T> {
        let listener = Listener(eventSource: self, handler: handler)
        listeners.append(listener)
        return listener
    }
    
    func unlisten(_ listener: Listener<T>) {
        if let pool = unlistenPools.last {
            pool.listeners.append(listener)
        } else {
            if let index = listeners.index(of: listener) {
                listeners.remove(at: index)
            }
        }
    }

    ///
    /// Dispaches an event to its listeners.
    ///
    /// - Parameter value: An event value.
    ///
    public func fire(_ value: T) {
        unlistenPools.append(UnlistenPool<T>())
        
        listeners.forEach { listener in
            listener.handleEvent(value)
        }
        
        let pool = unlistenPools.removeLast()
        
        if pool.listeners.count > 0 {
            listeners = listeners.filter { !pool.listeners.contains($0) }
        }
    }
}
