////
////  TestingWithStasTests.swift
////  TestingWithStasTests
////
////  Created by Yurii on 2022/12/10.
////
//
//import XCTest
//import SSSugarTesting
//
//@testable import TestingWithStas
//
////TODO: - Handling exceptions
////TODO: - Apply executor
//
////Y
////TODO: - Finish tests  testRemoveBookSuccess() and testChangeAuthorForBookSuccess()
////Посмотреть реализацию фреймворка SSSugarTesting-SSMock Стаса и попробовать избавится от свойства Book в моем Моке
////Research SSMock.
////Modify your Mock, achieve:
//// • Remove property Book (to make return configurable)
//// • Remove enum Call (to make Mock more universal)
//// • Deal with arguments comparision
//final class TestingWisthStasTests: XCTestCase {
//
//	var sut: BookManager!
//	var storageMock = DBStoragseMock()
//	
//	override func setUp() {
//		sut = .init(storage: storageMock)
//	}
//
//	override func tearDown() {
//		sut = nil
//	}
//
//	func testAddBookSuccess() {
//		let exp = XCTestExpectation()
//		let id = 1
//		let book = Book(id: id, title: "The Bible", author: "Jesus")
//		
//		storageMock.expectGet(book: nil, with: id)
//		storageMock.expectInsert(book: book)
//		
//		sut.add(book: book) { error in
//			XCTAssertNil(error)
//			exp.fulfill()
//		}
//		
//		wait(for: [exp], timeout: 0.1)
//		storageMock.verify()
//	}
//
//	func testRemoveBookSuccess() {
//		let exp = XCTestExpectation()
//		let id = 1
//		let book = Book(id: 1, title: "The Bible", author: "Jesus")
//
//		storageMock.expectGet(book: book, with: id)
//		storageMock.expectDelete(with: id)
//
//		sut.removeBook(with: 1) { error in
//			XCTAssertNil(error)
//			exp.fulfill()
//		}
//
//		wait(for: [exp], timeout: 0.1)
//		storageMock.verify()
//	}
//
//	func testChangeAuthorForBookSuccess() {
//		let id = 1
//		let newAuthor = "Stalin"
//		let book = Book(id: id, title: "The Bible", author: "Jesus")
//		var updatedBook = book
//		updatedBook.author = newAuthor
//
//		let exp = XCTestExpectation()
//		
//		storageMock.expectGet(book: book, with: id)
//		storageMock.expectUpdate(book: updatedBook)
//		
//		sut.changeAuthorForBook(with: id, newAuthor: newAuthor) { error in
//			XCTAssertNil(error)
//			exp.fulfill()
//		}
//
//		wait(for: [exp], timeout: 0.1)
//	}
//}
//
//final class DBStoragseMock: SSMock, BookStorage {
//	
//	func insert(book: Book) throws {
//		try call(book)
//	}
//	
//	func getBook(with id: Book.ID) -> Book? {
//		return try! call(id)
//	}
//	
//	func deleteBook(with id: Book.ID) throws {
//		try call(id)
//	}
//	
//	func update(book: Book) throws {
//		try call(book)
//	}
//	
//	func expectGet(book: Book?, with id: Book.ID) {
//		expect(result: book) { mock, args in mock.getBook(with: args.eq(id)) }
//	}
//	
//	func expectInsert(book: Book) {
//		expect { try $0.insert(book: $1.eq(book)) }
//	}
//	
//	func expectDelete(with id: Book.ID) {
//		expect { try $0.deleteBook(with: $1.eq(id)) }
//	}
//	
//	func expectUpdate(book: Book) {
//		expect { try $0.update(book: $1.eq(book)) }
//	}
//}
