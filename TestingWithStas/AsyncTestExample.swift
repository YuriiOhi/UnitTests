//
//  AsyncTestExample.swift
//  TestingWithStasTests
//
//  Created by Yurii on 2022/12/14.
//

import XCTest

final class AsyncTestExample: XCTestCase {

	func testAsyncSmth() {

		let exp = XCTestExpectation()
		var val = 0
		
		DispatchQueue.main.async {
			val = 5
			exp.fulfill()
		}
		
		wait(for: [exp], timeout: 0.1)
		XCTAssertEqual(val, 5)
	}
}
