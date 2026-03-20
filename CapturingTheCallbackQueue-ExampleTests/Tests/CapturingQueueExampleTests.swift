//
//  CapturingTheCallbackQueue_ExampleTests.swift
//  CapturingTheCallbackQueue-ExampleTests
//
//  Created by William Boles on 14/04/2017.
//  Copyright © 2017 William Boles. All rights reserved.
//

import XCTest

@testable import CapturingTheCallbackQueue_Example

final class CapturingQueueExampleTests: XCTestCase {
    var sut: CapturingQueueExample!

    // MARK: - Lifecycle
    
    override func setUp() {
        super.setUp()
        
        sut = CapturingQueueExample()
    }

    override func tearDown() {
        sut = nil
        
        super.tearDown()
    }

    // MARK: - Tests

    func test_givenPerformWorkIsCalled_whenUsingDefaultCallbackQueue_thenCallsBackOnMainQueue() {
        let expectation = expectation(description: "completion called")

        sut.performWork { result in
            XCTAssertTrue(Thread.isMainThread)
            XCTAssertEqual(try? result.get(), "Done")
            
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5)
    }

    func test_givenPerformWorkIsCalled_whenSpecifyingCallbackQueue_thenCallsBackOnThatQueue() {
        let callbackQueue = DispatchQueue(label: "com.williamboles.test-callback")
        let callbackQueueKey = DispatchSpecificKey<Bool>()
        callbackQueue.setSpecific(key: callbackQueueKey, value: true)
        
        let expectation = expectation(description: "completion called")

        sut.performWork(callbackQueue: callbackQueue) { result in
            XCTAssertTrue(DispatchQueue.getSpecific(key: callbackQueueKey) == true)
            XCTAssertEqual(try? result.get(), "Done")
            
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5)
    }
}
