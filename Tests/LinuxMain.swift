import XCTest

import workTests

var tests = [XCTestCaseEntry]()
tests += workTests.allTests()
XCTMain(tests)