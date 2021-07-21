//
//  DIP.swift
//  swift-design-patterns
//
//  Created by sanjeev on 18/07/21.
//

import Foundation

enum Relationship {
	case parent
	case child
	case sibling
}

class Person {
	var name: String
	
	init(_ name: String) {
		self.name = name
	}
}

// Interface/Protocol through which HLM talks to LLM
protocol RelationShipBrowser {
	func findAllChild(_ name: String) -> [Person]
}

// Low Level Module
class RelationShips : RelationShipBrowser {
	var relations = [(Person, Relationship, Person)]()
	
	func addParentAndChild(_ parent: Person, _ child: Person) {
		relations.append((parent, Relationship.parent, child))
		relations.append((child, Relationship.child, parent))
	}
	
	func findAllChild(_ name: String) -> [Person] {
		return relations.filter {
			$0.0.name == name && $0.1 == .parent
		}.compactMap { $0.2 }
	}
}

class Research {
	init(_ relationships: RelationShips) {}
	// High Level Module
	init(_ browser: RelationShipBrowser) {
		let children = browser.findAllChild("john doe")
		print(children)
	}
}
