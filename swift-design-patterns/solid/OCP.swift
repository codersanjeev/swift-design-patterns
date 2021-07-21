//
//  OCP.swift
//  swift-design-patterns
//
//  Created by sanjeev on 17/07/21.
//

import Foundation

enum RatingRange {
	case poor
	case average
	case good
}

enum PriceRange {
	case low
	case medium
	case high
}

enum BookType {
	case paper
	case ebook
}

private class Book {
	var name: String
	var author: String
	var ratingRange: RatingRange
	var priceRange: PriceRange
	var bookType: BookType
	
	init(
		_ name: String,
		_ author: String,
		_ ratingRange: RatingRange,
		_ priceRange: PriceRange,
		_ bookType: BookType
	) {
		self.name = name
		self.author = author
		self.ratingRange = ratingRange
		self.priceRange = priceRange
		self.bookType = bookType
	}
}

// MARK:- Wrong Approach
// class responsible for filtering Books based on
// certain requirements.
private class BookFilter {
	// Get books of given ratings only.
	func filterByRatings(_ books: [Book], _ rating: RatingRange) -> [Book] {
		return books.filter {
			$0.ratingRange == rating
		}
	}
	
	// Get book of given price range only
	func filterByPrice(_ books: [Book], _ price: PriceRange) -> [Book] {
		return books.filter {
			$0.priceRange == price
		}
	}
	
	// Get book of given ratings and given price range.
	func filterByPriceAndRatings(
		_ books: [Book],
		_ rating: RatingRange,
		_ price: PriceRange
	) -> [Book] {
		return books.filter {
			$0.ratingRange == rating && $0.priceRange == price
		}
	}
	
	// Drawback: Everytime a new requirement comes, we need to modify
	// existing well tested class, which is breaking OC principle.
}

// MARK:- Correct Approach
// Specification Enterprice Pattern.
protocol Specification {
	associatedtype T
	func isSatisfied(_ item: T) -> Bool
}

protocol Filter {
	associatedtype T
	func filter<Spec : Specification>(_ items: [T], _ specification: Spec) -> [T]
	where Spec.T == T
}

class RatingSpecification : Specification {
	typealias T = Book
	let rating: RatingRange
	
	init(_ rating: RatingRange) {
		self.rating = rating
	}
	
	func isSatisfied(_ item: Book) -> Bool {
		return item.ratingRange == rating
	}
}

class PriceSpecification : Specification {
	typealias T = Book
	let price: PriceRange
	
	init(_ price: PriceRange) {
		self.price = price
	}
	
	func isSatisfied(_ item: Book) -> Bool {
		return item.priceRange == price
	}
}

class AndSpecification<
	T,
	SpecificationOne: Specification,
	SpecificationTwo: Specification
> : Specification where SpecificationOne.T == SpecificationTwo.T, T == SpecificationOne.T {
	
	let first: SpecificationOne
	let second: SpecificationTwo
	
	init(_ first: SpecificationOne, _ second: SpecificationTwo) {
		self.first = first
		self.second = second
	}
	
	func isSatisfied(_ item: T) -> Bool {
		return first.isSatisfied(item) && second.isSatisfied(item)
	}
	
}

class BookFilterCorrected: Filter {
	typealias T = Book
	
	func filter<Spec: Specification>(_ items: [Book], _ specification: Spec) -> [Book] where Spec.T == T {
		return items.filter {
			specification.isSatisfied($0)
		}
	}
	
}

// MARK:- Usage
//let bookOne = Book("Book One", "Book One Author", .good, .medium, .paper)
//let bookTwo = Book("Book Two", "Book Two Author", .poor, .low, .ebook)
//let bookThree = Book("Book Three", "Book Three Author", .average, .high, .ebook)
//
//let books = [bookOne, bookTwo, bookThree]
//
//let booksFilter = BookFilter()
//let highRatedBooks = booksFilter.filterByRatings(books, .good)
//for book in highRatedBooks {
//	println(book)
//}
//let bookFilterCorrected = BookFilterCorrected()
//let highRatedBooks = bookFilterCorrected.filter(books, RatingSpecification(.good))
//for book in highRatedBooks {
//	println(book)
//}
//let highRatedAndMediumCostBooks = bookFilterCorrected.filter(books, AndSpecification(RatingSpecification(.good), PriceSpecification(.medium)))
//for book in highRatedAndMediumCostBooks {
//	print(book)
//}
