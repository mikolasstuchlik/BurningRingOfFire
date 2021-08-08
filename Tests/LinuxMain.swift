import XCTest
@testable import FTAPIKitTests

XCTMain([
    testCase(StorageTests.allTests),
    testCase(FioAPITests.allTests),
])
