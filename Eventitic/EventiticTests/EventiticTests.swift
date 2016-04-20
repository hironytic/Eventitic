//
// EventiticTests.swift
// EventiticTests
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

import XCTest

@testable import Eventitic

class EventiticTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    // MARK: Event Listening
    
    func testShouldListenAFiredEvent() {
        var values: [Int] = []
        
        let source = EventSource<Int>()
        source.listen { value in
            values.append(value)
        }
        
        source.fire(10)
        
        XCTAssertEqual(values.count, 1)
        XCTAssertEqual(values[0], 10)
    }
    
    func testShouldListenTwoFiredEvents() {
        var values: [Int] = []
        
        let source = EventSource<Int>()
        source.listen { value in
            values.append(value)
        }
        
        source.fire(10)
        source.fire(20)

        XCTAssertEqual(values.count, 2)
        XCTAssertEqual(values[0], 10)
        XCTAssertEqual(values[1], 20)
    }
    
    func testShouldDispatchToTwoListeners() {
        var values1: [String] = []
        var values2: [String] = []
        
        let source = EventSource<String>()
        
        source.listen { value in
            values1.append("#1: \(value)")
        }
        
        source.listen { value in
            values2.append("#2: \(value)")
        }
        
        source.fire("foo")
        
        XCTAssertEqual(values1.count, 1)
        XCTAssertEqual(values2.count, 1)
        XCTAssertEqual(values1[0], "#1: foo")
        XCTAssertEqual(values2[0], "#2: foo")
    }
    
    // MARK: Unlistening to a Event
    
    func testShouldUnlisten() {
        var values1: [String] = []
        var values2: [String] = []
        
        let source = EventSource<String>()
        
        let listener1 = source.listen { value in
            values1.append("#1: \(value)")
        }
        
        source.listen { value in
            values2.append("#2: \(value)")
        }
        
        source.fire("foo")
        
        listener1.unlisten()
        
        source.fire("bar")
        
        XCTAssertEqual(values1.count, 1)
        XCTAssertEqual(values2.count, 2)
        XCTAssertEqual(values1[0], "#1: foo")
        XCTAssertEqual(values2[0], "#2: foo")
        XCTAssertEqual(values2[1], "#2: bar")
    }
    
    func testShouldUnlistenEvenInHandler() {
        var values1: [String] = []
        var values2: [String] = []
        
        let source = EventSource<String>()
        
        var listener1: Listener<String>? = nil
        listener1 = source.listen { value in
            values1.append("#1: \(value)")
            listener1?.unlisten()
        }
        
        source.listen { value in
            values2.append("#2: \(value)")
        }
        
        source.fire("foo")
        source.fire("bar")
        
        XCTAssertEqual(values1.count, 1)
        XCTAssertEqual(values2.count, 2)
        XCTAssertEqual(values1[0], "#1: foo")
        XCTAssertEqual(values2[0], "#2: foo")
        XCTAssertEqual(values2[1], "#2: bar")
    }
    
    // MARK: Listener Store
    
    func testShouldMakeAllListenersUnlistened() {
        var values1: [String] = []
        var values2: [String] = []
        
        let listenerStore = ListenerStore()
        
        let source = EventSource<String>()
        
        source.listen { value in
            values1.append("#1: \(value)")
            }.addToStore(listenerStore)
        
        source.listen { value in
            values2.append("#2: \(value)")
            }.addToStore(listenerStore)
        
        source.fire("foo")
        
        listenerStore.unlistenAll()
        
        source.fire("bar")
        
        XCTAssertEqual(values1.count, 1)
        XCTAssertEqual(values2.count, 1)
        XCTAssertEqual(values1[0], "#1: foo")
        XCTAssertEqual(values2[0], "#2: foo")
    }
}
