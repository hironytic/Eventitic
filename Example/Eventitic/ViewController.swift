//
// ViewController.swift
// Eventitic_Example
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

import UIKit
import Eventitic

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sample1()
        sample2()
    }

    func sample1() {
        let source = EventSource<String>()
        
        // listen
        let listener = source.listen { message in
            print(message)
        }
        
        // dispatch
        source.fire("Hello, World!")

        // unlisten
        listener.unlisten()
    }
    
    func sample2() {
        let store = ListenerStore()

        let source1 = EventSource<String>()
        let source2 = EventSource<Int>()
        
        // listen
        source1.listen { message in
            print("listener 1: \(message)")
        }.addToStore(store)
        
        source1.listen { message in
            print("listener 2: \(message)")
        }.addToStore(store)
        
        source2.listen { value in
            print("listener 3: \(value)")
        }.addToStore(store)

        // dispatch
        source1.fire("foo")
        source2.fire(10)
        
        // unlisten all
        store.unlistenAll()
    }
}

