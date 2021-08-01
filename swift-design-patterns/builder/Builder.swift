//
//  Builder.swift
//  swift-design-patterns
//
//  Created by sanjeev on 25/07/21.
//

import Foundation


// Builder Pattern Example: Output text in HTML formatted way.

// MARK:- Naive Approach
let hello = "Hello"
var result = "<p>\(hello)</p>"
print(result)

let words = ["hello", "world"]
result = "<ul>\n"
for word in words {
	result.append("<li>\(word)</li>\n")
}
result.append("</ul>")
print(result)

// This is going to become more and more complex

// MARK:- Nice Approach
class HTMLElement: CustomStringConvertible {
	var name = ""
	var text = ""
	var elements = [HTMLElement]()
	private let indentSize = 4
	
	init() {}
	
	init(name: String, text: String) {
		self.name = name
		self.text = text
	}
	
	private func description(_ indent: Int) -> String {
		var result = ""
		let i = String(repeating: " ", count: indentSize)
		result += "\(i)<\(name)>\n"
		if !text.isEmpty {
			result += String(repeating: " ", count: indentSize + 1)
			result += "\(text)\n"
		}
		for e in elements {
			result += e.description(indent + 1)
		}
		result += "\(i)</\(name)>\n"
		return result
	}
	
	var description: String {
		return description(0)
	}
}

class HTMLBuilder: CustomStringConvertible {
	private let rootName: String
	var root = HTMLElement()
	
	init(rootName: String) {
		self.rootName = rootName
		root.name = rootName
	}
	
	func addChild(name: String, text: String) {
		let e = HTMLElement(name: name, text: text)
		root.elements.append(e)
	}
	
	func addChildFluent(name: String, text: String) -> HTMLBuilder {
		let e = HTMLElement(name: name, text: text)
		root.elements.append(e)
		return self
	}
	
	var description: String {
		return root.description
	}
	
	func clear() {
		root = HTMLElement(name: rootName, text: "")
	}
}

let builder = HTMLBuilder(rootName: "ul")
//builder.addChild(name: "li", text: "Hello")
//builder.addChild(name: "li", text: "World")
builder.addChildFluent(name: "li", text: "Hello")
	.addChildFluent(name: "li", text: "World")
print(builder)

// MARK:- More Complex Example for Builder Pattern

class Person: CustomStringConvertible {
	// Address
	var streetAddress = "", postcode = "", city = ""
	// Employment
	var companyName = "", position = ""
	var annualIncome = 0
	
	var description: String {
		return "Person lives in \(streetAddress), \(postcode), \(city). Person works at \(companyName) as a \(position), earning \(annualIncome)."
	}
}

class PersonBuilder {
	var person = Person()
	var lives: PersonAddressBuilder {
		return PersonAddressBuilder(person)
	}
	var works: PersonJobBuilder {
		return PersonJobBuilder(person)
	}
	
	func build() -> Person {
		return person
	}
}

class PersonJobBuilder: PersonBuilder {
	internal init(_ person: Person) {
		super.init()
		self.person = person
	}
	
	func at(_ companyName: String) -> PersonJobBuilder {
		person.companyName = companyName
		return self
	}
	
	func asA(_ position: String) -> PersonJobBuilder {
		person.position = position
		return self
	}
	
	func earning(_ annualIncome: Int) -> PersonJobBuilder {
		person.annualIncome = annualIncome
		return self
	}
}

class PersonAddressBuilder: PersonBuilder {
	internal init(_ person: Person) {
		super.init()
		self.person = person
	}
	
	func at(_ streetAddress: String) -> PersonAddressBuilder {
		person.streetAddress = streetAddress
		return self
	}
	
	func withPostCode(_ postcode: String) -> PersonAddressBuilder {
		person.postcode = postcode
		return self
	}
	
	func inCity(_ city: String) -> PersonAddressBuilder {
		person.city = city
		return self
	}
}


let personBuilder = PersonBuilder()
let person = personBuilder
	.lives
	.at("Sand Dunes")
	.inCity("Mars")
	.withPostCode("007")
	.works
	.at("NASA")
	.asA("Astronaut")
	.earning(9999)
	.build()

print(person)

