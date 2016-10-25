# Eventitic

[![CI Status](http://img.shields.io/travis/hironytic/Eventitic.svg?style=flat)](https://travis-ci.org/hironytic/Eventitic)
[![Version](https://img.shields.io/cocoapods/v/Eventitic.svg?style=flat)](http://cocoapods.org/pods/Eventitic)
[![License](https://img.shields.io/cocoapods/l/Eventitic.svg?style=flat)](http://cocoapods.org/pods/Eventitic)
[![Platform](https://img.shields.io/cocoapods/p/Eventitic.svg?style=flat)](http://cocoapods.org/pods/Eventitic)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

Library for dispatching and listening events.

## Usage

Events are dispatched by `EventSource`.

```swift
let source = EventSource<String>()

// listen
let listener = source.listen { message in
    print(message)
}

// dispatch
source.fire("Hello, World!")

// unlisten
listener.unlisten()
```

There is a utility class `ListenerStore` which holds listeners and makes it possible to unlisten them all later.

```swift
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
```

## Requirements

- iOS 8.0+
- OS X 10.9+
- watchOS 2.0+
- tvOS 9.0+
- Swift 3.0+

## Installation

### CocoaPods

Eventitic is available through [CocoaPods](http://cocoapods.org).
To install it, simply add the following lines to your Podfile:

```ruby
use_frameworks!
pod "Eventitic", '~> 2.0'
```

### Carthage

Eventitic is available through [Carthage](https://github.com/Carthage/Carthage).
To install it, simply add the following line to your Cartfile:

```
github "hironytic/Eventitic" ~> 2.0
```

### Swift Package Manager

Eventitic is available through [Swift Package Manager](https://swift.org/package-manager/).
To install it, add dependency to your `Package.swift` file like following:

```swift
import PackageDescription

let package = Package(
    name: "Hello",
    dependencies: [
        .Package(url: "https://github.com/hironytic/Eventitic.git", majorVersion: 2),
    ]
)
```

## Author

Hironori Ichimiya, hiron@hironytic.com

## License

Eventitic is available under the MIT license. See the LICENSE file for more info.
