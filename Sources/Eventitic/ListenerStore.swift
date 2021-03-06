//
// ListenerStore.swift
// Eventitic
//
// Copyright (c) 2016-2018 Hironori Ichimiya <hiron@hironytic.com>
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
/// This is a utility class which holds listeners and makes it possible to unlisten them all.
///
public class ListenerStore {
    private var items: [Unlistenable]
    
    /// Initializes an object.
    public init() {
        items = []
    }
    
    deinit {
        unlistenAll()
    }
    
    ///
    /// Adds a listener.
    ///
    /// - Parameter listener: A listener which will be added to this store.
    ///
    public func add(_ listener: Unlistenable) {
        items.append(listener)
    }

    ///
    /// Makes all listeners in this store unlisten.
    ///
    public func unlistenAll() {
        items.forEach { $0.unlisten() }
        items.removeAll()
    }
}
