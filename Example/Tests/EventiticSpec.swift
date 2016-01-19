//
// EventiticSpec.swift
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

import Quick
import Nimble
import Eventitic

class EventiticSpec: QuickSpec {
    override func spec() {
        describe("event listening") {
            it("can listen a fired event") {
                var values: [Int] = []
                
                let source = EventSource<Int>()
                source.listen { value in
                    values.append(value)
                }
                
                source.fire(10);
                
                expect(values.count) == 1
                expect(values[0]) == 10
            }
            
            it("can listen two fired events") {
                var values: [Int] = []
                
                let source = EventSource<Int>()
                source.listen { value in
                    values.append(value)
                }
                
                source.fire(10);
                source.fire(20);
                
                expect(values.count) == 2
                expect(values[0]) == 10
                expect(values[1]) == 20
            }
            
            it("can have two listeners") {
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
                
                expect(values1.count) == 1
                expect(values2.count) == 1
                expect(values1[0]) == "#1: foo"
                expect(values2[0]) == "#2: foo"
            }
        }
        
        describe("unlistening to a event") {
            it("can unlisten") {
                var values1: [String] = []
                var values2: [String] = []
                
                let source = EventSource<String>()
                
                let listener1 = source.listen { value in
                    values1.append("#1: \(value)")
                }
                
                source.listen { value in
                    values2.append("#2: \(value)")
                }
                
                source.fire("foo");
                
                listener1.unlisten()
                
                source.fire("bar");
                
                expect(values1.count) == 1
                expect(values2.count) == 2
                expect(values1[0]) == "#1: foo"
                expect(values2[0]) == "#2: foo"
                expect(values2[1]) == "#2: bar"
            }
            
            it("can unlisten in handler") {
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
                
                source.fire("foo");
                source.fire("bar");
                
                expect(values1.count) == 1
                expect(values2.count) == 2
                expect(values1[0]) == "#1: foo"
                expect(values2[0]) == "#2: foo"
                expect(values2[1]) == "#2: bar"
            }
        }
        
        describe("listener store") {
            it("can make all listeners unlistened") {
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
                
                source.fire("foo");
                
                listenerStore.unlistenAll()
                
                source.fire("bar");
                
                expect(values1.count) == 1
                expect(values2.count) == 1
                expect(values1[0]) == "#1: foo"
                expect(values2[0]) == "#2: foo"
            }
        }
    }
}
