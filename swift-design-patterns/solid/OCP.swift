//
//  OCP.swift
//  swift-design-patterns
//
//  Created by sanjeev on 17/07/21.
//

import Foundation

enum AverageRating {
	case greaterThanEqualToOne
	case greaterThanEqualToTwo
	case greaterThanEqualToThree
	case greaterThanEqualToFour
}

enum PriceRange {
	case lessThanFifty
	case betweenFiftyAndHundred
	case betweenHundredAndTwoHundred
	case betweenTwoHundredAndFiveHundred
	case greaterThanFiveHundred
}

enum Discount {
	case greaterThanTenPercent
	case greaterThanTwentyFivePercent
	case greaterThanThirtyFivePercent
	case greaterThanFiftyPercent
}

class Book {
	var pages: [String]
	var averageRating: AverageRating
	var priceRange: PriceRange
	var discount: Discount
	
	init(
		_ pages: [String],
		_ averageRating: AverageRating,
		_ priceRange: PriceRange,
		_ discount: Discount
	) {
		self.pages = pages
		self.averageRating = averageRating
		self.priceRange = priceRange
		self.discount = discount
	}
}

// MARK:- Wrong Approach
class BooksFilter {
	func filterByRatings(
		_ books: [Book],
		_ rating: AverageRating
	) -> [Book] {
		return books.filter{ $0.averageRating == rating }
	}
	
	// Added Filter By Price
	func filterByPrice(
		_ books: [Book],
		_ price: PriceRange
	) -> [Book] {
		return books.filter{ $0.priceRange == price }
	}
}

// MARK:- Correct Approach
protocol Specifiable {
	associatedtype T
	func isSatisfied(_ item: T) -> Bool
}

protocol Filterable {
	associatedtype T
	func filter<Specification:Specifiable>(
		_ items: [T],
		_ specifiction: Specification
	) -> [T] where Specification.T == T
}

class RatingsSpecification: Specifiable {
	typealias T = Book
	private let rating: AverageRating
	
	init(_ rating: AverageRating) {
		self.rating = rating
	}
	
	func isSatisfied(_ item: Book) -> Bool {
		return item.averageRating == rating
	}
}

class PriceFilterSpecification: Specifiable {
	typealias T = Book
	private let price: PriceRange
	
	init(_ price: PriceRange) {
		self.price = price
	}
	
	func isSatisfied(_ item: Book) -> Bool {
		return item.priceRange == price
	}
}

class ANDSpecification<
	T,
	SpecificationA: Specifiable,
	SpecificationB: Specifiable
> : Specifiable where SpecificationA.T == SpecificationB.T, T == SpecificationA.T {
	let specificationA: SpecificationA
	let specificationB: SpecificationB
	
	init(_ specificationA: SpecificationA, _ specificationB: SpecificationB) {
		self.specificationA = specificationA
		self.specificationB = specificationB
	}
	
	func isSatisfied(_ item: T) -> Bool {
		return specificationA.isSatisfied(item) && specificationB.isSatisfied(item)
	}
}

class BooksFilter: Filterable {
	typealias T = Book
	
	func filter<Specification>(
		_ items: [Book],
		_ specifiction: Specification
	) -> [Book] where Specification : Specifiable, Book == Specification.T {
		return items.filter{ specifiction.isSatisfied($0) }
	}
}

let books = [Book]()
let booksFilter = BooksFilter()

// we want books rated >= 4, so creating this specification.
let ratingsSpecification = RatingsSpecification(.greaterThanEqualToFour)

let ratedBooks = booksFilter.filter(books, ratingsSpecification)
print(ratedBooks)

let priceSpecification = PriceFilterSpecification(.betweenHundredAndTwoHundred)
let cheapBooks = booksFilter.filter(books, priceSpecification)

let ratingAndPriceSpecification = ANDSpecification(ratingsSpecification, priceSpecification)
let cheapAndHighRatedBooks = booksFilter.filter(ratedBooks, ratingAndPriceSpecification)

