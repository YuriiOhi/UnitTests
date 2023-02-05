//
//  TestExamples.swift
//  TestingWithStas
//
//  Created by Yurii on 2022/12/10.
//

import Foundation

protocol TimeProvider {

	func currentTime() -> Int

}


final class DateBasedTimeProvider: TimeProvider {

	func currentTime() -> Int {

		return Int(Date().timeIntervalSince1970)

	}

}


final class FortuneTeller {

	enum Result {

		case money

		case love

	}

	let timeProvider: TimeProvider

	

	init(timeProvider: TimeProvider = DateBasedTimeProvider()) {

		self.timeProvider = timeProvider

	}

	

	func tell() -> Result {

		let time = timeProvider.currentTime()

		

		if time % 2 == 0 {

			return .money

		}

		return .love

	}

}
