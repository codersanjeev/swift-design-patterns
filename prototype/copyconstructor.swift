import Foundation

protocol Copyable {
	init(copyFrom: Self)
}

class Address: CustomStringConvertible, Copyable {
	var streetAddress: String
	var city: String
	
	init(_ streetAddress: String, _ city: String) {
		self.streetAddress = streetAddress
		self.city = city
	}
	
	required init(copyFrom: Address) {
		streetAddress = copyFrom.streetAddress
		city = copyFrom.city
	}
	
	var description: String {
		return "\(streetAddress), \(city)"
	}
}

class Employee: CustomStringConvertible, Copyable {
	var name: String
	var address: Address
	
	init(_ name: String, _ address: Address) {
		self.name = name
		self.address = address
	}
	
	required init(copyFrom: Employee) {
		name = copyFrom.name
		address = Address.init(copyFrom: copyFrom.address)
	}
	
	var description: String {
		return "Name is \(name) and I live at \(address)"
	}
}

let foo = Employee("Foo", Address("123 London Road", "London"))
// Allow replication without copying references, instead making actual deep copy.
let bar = Employee.init(copyFrom: foo)
bar.name = "Bar"
debugPrint(foo)
debugPrint(bar)
