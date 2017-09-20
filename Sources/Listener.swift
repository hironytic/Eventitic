//
// Listener.swift
// Eventitic
//
// Copyright (c) 2016,2017 Hironori Ichimiya <hiron@hironytic.com>
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

///
/// A protocol conformed to by types which can unlisten to events.
///
public protocol Unlistenable {
    ///
    /// Stops listening.
    ///
    func unlisten()
}

///
/// This class represents a listener of specific event source.
///
public class Listener<T>: Unlistenable, Equatable {
    public typealias Handler = (T) -> Void

    private let eventSource: EventSource<T>
    private let handler: Handler
 
    init(eventSource: EventSource<T>, handler: @escaping Handler) {
        self.eventSource = eventSource
        self.handler = handler
    }
    
    func handleEvent(_ value: T) {
        handler(value)
    }
    
    ///
    /// Stops listening.
    ///
    public func unlisten() {
        eventSource.unlisten(self)
    }
    
    ///
    /// Adds this object to specified listener store.
    /// Calling this method is equivalent to calling `ListenerStore.add(_:)` with this object as a parameter.
    ///
    /// - Parameter listenerStore: A listener store to which this object is added.
    /// - SeeAlso: `ListenerStore.add(_:)`
    ///
    public func addToStore(_ listenerStore: ListenerStore) {
        listenerStore.add(self)
    }
}

///
/// Checks equality of two `Listener`s.
///
public func ==<T>(lhs: Listener<T>, rhs: Listener<T>) -> Bool {
    return lhs === rhs
}
