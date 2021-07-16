//
//  SRP.swift
//  swift-design-patterns
//
//  Created by sanjeev on 17/07/21.
//

import Foundation

// Class to represent a Book, which maintains
// pages and their count
class Book: CustomStringConvertible {
	var pages = [String]()
	var count = 0
	
	func addPage(_ text: String) -> Int {
		count += 1
		pages.append("\(count) and \(text)")
		return count - 1
	}
	
	func removePage(_ index: Int) {
		pages.remove(at: index)
	}
	
	var description: String {
		return pages.joined(separator: "\n")
	}
	
	// MARK:- Wrong Approach
	// adding below three functions in the same class is going to break
	// the Single Responsibility Principle or Separation of Concerns.
	func save(_ filename: String, _ overwrite: Bool = false) {}
	
	func load(_ filename: String) -> Book? {
		return nil
	}
	
	func load(_ url: URL) -> Book? {
		return nil
	}
}

// MARK:- Correct Approach
// Correct approach will be to create a separate class for Persistence and
// let this class handle the responsibility of saving and loading a Book.
class Persistence {
	func save(
		_ book: Book,
		_ filename: String,
		_ overwrite: Bool = false
	) {}
	
	func load(_ filename: String) -> Book? {
		return nil
	}
	
	func load(_ url: URL) -> Book? {
		return nil
	}
}

// MARK:- Usage
//let book = Book()
//let _ = book.addPage("This is first page content...")
//let secondPage = book.addPage("This is second page content...")
//print(book)
//book.removePage(secondPage)
//print(book)
//
//let persistence = Persistence()
//persistence.save(book, "/mnt/sdcard/mybooks")
