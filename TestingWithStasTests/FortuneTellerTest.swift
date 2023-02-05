//
//  FortuneTellerTest.swift
//  TestingWithStasTests
//
//  Created by Yurii on 2022/12/10.
//

import XCTest

@testable import TestingWithStas

final class ExampleTest: XCTestCase {

	var sut: FortuneTeller!

	var timeProvider: TimeProviderStub!

	override func setUp() {

		timeProvider = .init()

		sut = .init(timeProvider: timeProvider)
	}

	override func tearDown() {

		sut = nil

		timeProvider = nil
		
	}

	func testTellMultipleTimes() {

		func check(step: Int) {

			let expected = makeExpectedResult(step: step)

		
			timeProvider.time = step

			XCTAssertEqual(sut.tell(), expected)
		}
		
		(0..<10_000_000).forEach {

			check(step: $0)

		}

	}
	
	func testTell_whenMax() {

		let time = Int.max

		let expected = makeExpectedResult(step: time)

		timeProvider.time = time

		XCTAssertEqual(sut.tell(), expected)
	}

	private func makeExpectedResult(step: Int) -> FortuneTeller.Result {

		if step % 2 == 0 {

			return .money

		}

		return .love

	}
}

final class TimeProviderStub: TimeProvider {

	var time = 0

	func currentTime() -> Int {

		return time

	}

}
