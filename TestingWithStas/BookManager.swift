//
//  BookManager.swift
//  TestingWithStas
//
//  Created by Yurii on 2022/12/10.
//
import Foundation

struct Book: Identifiable, Equatable {
	let id: Int
	let title: String
	var author: String
}

protocol BookStorage {
	func insert(book: Book) throws
	func getBook(with id: Book.ID) -> Book?
	func deleteBook(with id: Book.ID) throws
	func update(book: Book) throws
}

final class BookManager {
	private let queue = DispatchQueue(label: "bg_queue")
	private let storage: BookStorage
	
	init(storage: BookStorage) {
		self.storage = storage
	}
	
	func add(book: Book, handler: @escaping (Error?) -> Void) {
		queue.async { [weak self] in
			do {
				try self?.addBook(book: book)
				handler(nil)
			} catch {
				handler(error)
			}
		}
	}
	
	func removeBook(with id: Book.ID, handler: @escaping (Error?) -> Void) {
		queue.async { [weak self] in
			do {
				try self?.deleteBook(with: id)
				handler(nil)
			} catch {
				handler(error)
			}
		}
	}
	
	func changeAuthorForBook(with id: Book.ID, newAuthor: String, handler: @escaping (Error?) -> Void) {
		queue.async { [weak self] in
			do {
				try self?.changeAuthorForBook(with: id, newAuthor: newAuthor)
				handler(nil)
			} catch {
				handler(error)
			}
		}
	}
	
	private func addBook(book: Book) throws {
		guard storage.getBook(with: book.id) == nil else {
			throw DBBookStorageError.alreadyExist(book.id)
		}
		try storage.insert(book: book)
	}
	
	private func deleteBook(with id: Book.ID) throws {
		guard storage.getBook(with: id) != nil else {
			throw DBBookStorageError.notExist(id)
		}
		try storage.deleteBook(with: id)
	}
	
	private func changeAuthorForBook(with id: Book.ID, newAuthor: String) throws {
		do {
			guard var book = storage.getBook(with: id) else {
				throw DBBookStorageError.notExist(id)
			}
			book.author = newAuthor
			try storage.update(book: book)
		}
	}
}


enum DBBookStorageError: Error {
	case alreadyExist(Book.ID)
	case notExist(Book.ID)
}
