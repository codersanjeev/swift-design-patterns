
class Person: CustomStringConvertible {
	var streetAddress = "", postCode = "", city = ""
	var companyName = "", position = ""
	var annualIncome = 0
	
	var description: String {
		return "I live at  \(streetAddress), \(postCode), \(city). I work at \(companyName) as a \(position) earning \(annualIncome)."
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

class PersonAddressBuilder: PersonBuilder {
	internal init(_ person: Person) {
		super.init()
		self.person = person
	}
	
	func at(_ streetAddress: String) -> PersonAddressBuilder {
		person.streetAddress = streetAddress
		return self
	}
	
	func withPostcode(_ postCode: String) -> PersonAddressBuilder {
		person.postCode = postCode
		return self
	}
	
	func inCity(_ city: String) -> PersonAddressBuilder {
		person.city = city
		return self
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
	
	func atPosition(_ position: String) -> PersonJobBuilder {
		person.position = position
		return self
	}
	
	func earning(_ annualIncome: Int) -> PersonJobBuilder {
		person.annualIncome = annualIncome
		return self
	}
}

let personBuilder = PersonBuilder()
let person = personBuilder.lives.at("123 London")
	.inCity("London")
	.withPostcode("SW12BC")
	.works.at("Microsoft")
	.atPosition("Developer")
	.earning(123000)
	.build()
print(person)
