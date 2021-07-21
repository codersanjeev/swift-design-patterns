//
//  ISP.swift
//  swift-design-patterns
//
//  Created by sanjeev on 18/07/21.
//

import Foundation

class Document {}

// MARK:- Wrong Approach
protocol Machine {
	func print(_ document: Document)
	func scan(_ document: Document)
	func fax(_ document: Document)
}

// This class is enforced to implement the functionalities,
// even though it might not need it.
class ConcretePrinter : Machine {
	func print(_ document: Document) {
		
	}
	
	func scan(_ document: Document) {
		
	}
	
	func fax(_ document: Document) {
		
	}
}

// MARK:- Correct Approach: Segregate Interfaces/Protocols
protocol Printer {
	func print(_ document: Document)
}

protocol Scanner {
	func scan(_ document: Document)
}

protocol Faxer {
	func fax(_ document: Document)
}
