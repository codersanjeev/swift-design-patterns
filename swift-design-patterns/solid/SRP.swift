//
//  SRP.swift
//  swift-design-patterns
//
//  Created by sanjeev on 17/07/21.
//

import Foundation

// MARK:- Wrong Approach
class Book {
	private var pages = [String]()
	
	func addPage(_ page: String) {
		pages.append(page)
	}
	
	func removePage(_ page: String) {
		pages = pages.filter { $0 != page }
	}
	
	func printBook() {
		// logic to print the hard copy of Book here
	}
}

// MARK:- Correct Approach
class Book {
	private var pages = [String]()
	
	func addPage(_ page: String) {
		pages.append(page)
	}
	
	func removePage(_ page: String) {
		pages = pages.filter { $0 != page }
	}
}

class BookPrinter {
	func printBook(_ book: Book) {
		// logic to print the hard copy of Book here
	}
}

let book = Book()
for page in 1 ... 100 {
	book.addPage("Page Number = \(page)")
}
let bookPrinter = BookPrinter()
bookPrinter.printBook(book)
