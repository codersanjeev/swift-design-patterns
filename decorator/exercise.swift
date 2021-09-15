protocol AgeProtocol {
	var age:  Int { get }
}

protocol Flyable: AgeProtocol {}

extension Flyable {
	func fly() -> String {
		return (age < 10) ? "flying" : "too old"
	}
}

protocol Crawlable: AgeProtocol {}

extension Crawlable {
	func crawl() -> String {
		return (age > 1) ? "crawling" : "too young"
	}
}

class Bird: Flyable {
	var age = 0
}

class Lizard: Crawlable {
	var age = 0
}

class Dragon: Flyable, Crawlable {
	var age: Int = 0
}