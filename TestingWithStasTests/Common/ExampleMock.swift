////
////  TestingWithStasTests.swift
////  TestingWithStasTests
////
////  Created by Yurii on 2022/12/10.
////
//
//import XCTest
//@testable import TestingWithStas
//
//final class TestingWithStasTMock: XCTestCase {
//
//	var sut: BookManager!
//	var storageMock = DBStorageMockMock()
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
//		storageMock.expect(call: .getBook(id: id))
//		storageMock.expect(call: .insert(book: book))
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
//		let book = Book(id: 1, title: "The Bible", author: "Jesus")
//		let exp = XCTestExpectation()
//		
//		storageMock.book = book
//		
//		storageMock.expect(call: .getBook(id: book.id))
//		storageMock.expect(call: .deleteBook(id: book.id))
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
//		let exp = XCTestExpectation()
//		
//		storageMock.book = book
//		updatedBook.author = newAuthor
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
//class BaseMockC<Call> {
//	private var expectedCalls = [Call]()
//	
//	private var isConsumed: Bool { expectedCalls.isEmpty }
//	
//	func expect(call: Call) {
//		expectedCalls.append(call)
//	}
//	
//	func verify() {
//		XCTAssertTrue(isConsumed)
//	}
//}
//
//extension BaseMockC where Call: Equatable {
//	func onCall(_ call: Call) {
//		XCTAssertEqual(expectedCalls.removeFirst(), call)
//	}
//}
//
//enum DBStorageCalLl: Equatable {
//	case insert(book: Book)
//	case getBook(id: Book.ID)
//	case deleteBook(id: Book.ID)
//	case update(book: Book)
//}
//
//final class DBStorageMockMock: BaseMock<DBStorageCalLl>, BookStorage {
//
//	var book: Book?
//
//	func insert(book: Book) throws {
//		onCall(.insert(book: book))
//	}
//
//	func getBook(with id: Book.ID) -> Book? {
//		onCall(.getBook(id: id))
//		return book
//	}
//
//	func deleteBook(with id: Book.ID) throws {
//		onCall(.deleteBook(id: id))
//	}
//
//	func update(book: Book) throws {
//		onCall(.update(book: book))
//	}
//}
