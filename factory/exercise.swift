import Foundation
import XCTest

class Person {
	var id: Int
	var name: String
	
	init(called name: String, withId id: Int) {
		self.name = name
		self.id = id
	}
}

class PersonFactory {
	
	private var personId = 0
	
	func createPerson(name: String) -> Person {
		let person = Person(called: name, withId: personId)
		personId += 1
		return person
	}
}