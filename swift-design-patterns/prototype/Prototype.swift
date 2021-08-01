//
//  Prototype.swift
//  swift-design-patterns
//
//  Created by sanjeev on 25/07/21.
//

import Foundation

// MARK:- Definition
// Prototype Pattern => A partially or fully initialized object that you copy(clone) and make use of.

// protocol for Deep Copy
protocol Copyable {
	init(copyFrom other: Self)
}

class Address: CustomStringConvertible, Copyable {
	var streetAddress: String
	var city: String
	
	init(_ streetAddress: String, _ city: String) {
		self.streetAddress = streetAddress
		self.city = city
	}
	
	required init(copyFrom other: Address) {
		streetAddress = other.streetAddress
		city = other.city
	}
	
	var description: String {
		return "\(streetAddress), \(city)"
	}
}

class Employee: CustomStringConvertible {
	var name: String
	var address: Address
	
	init(_ name: String, _ address: Address) {
		self.name = name
		self.address = address
	}
	
	init(copyFrom other: Employee) {
		name = other.name
		address = Address(copyFrom: other.address)
	}
	
	var description: String {
		return "Employee name is \(name) and lives at \(address)"
	}
}

var john = Employee("John", Address("Sand Dunes", "Mars"))
print(john)

var doe = john	// will be copied by reference

// how to make a deep copy? protocol and required init blocks.
var anotherDoe = Employee(copyFrom: john)
anotherDoe.name = "Doe"
print(anotherDoe)

