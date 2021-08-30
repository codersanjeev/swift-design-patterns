
enum Relationship {
	case Parent
	case Child
	case Sibling
}

class Person {
	var name = ""
	
	init(_ name: String) {
		self.name = name
	}
}

/// `Low Level Module`: Specifies how I'm storing the relationships between people.
class Relationships {
	var relations = [(Person, Relationship, Person)]()
	
	func addParentAndChild(_ parent: Person, _ child: Person) {
		relations.append((parent, Relationship.Parent, child))
		relations.append((child, Relationship.Child, parent))
	}
}

/// `High Level Module`: Doing some research on relationships.
class Research {
	/// Breaking `Dependency Inversion Principle` as High Level Module is directly depending on Low Level Module
	//  It is even aware of it's internal structure.
	init(_ relationships: Relationships) {
		let relations = relationships.relations
		for relation in relations where relation.0.name == "John" && relation.1 == Relationship.Parent {
			print("John has a child called \(relation.2.name)")
		}
	}
}

/// Correct Approach:
//  - make relations private in Relationships class.
//  - use a protocol for exposing required data, without exposing the complete internals to High Level Modules.

protocol RelationshipBrowser {
	func findAllChildren(ofName name: String) -> [Person]
}

// MARK:- Usage
func main() {
	let parent = Person("John")
	let relationships = Relationships()
	relationships.addParentAndChild(parent, Person("Chris"))
	relationships.addParentAndChild(parent, Person("Matt"))
	Research(relationships)
}

main()
