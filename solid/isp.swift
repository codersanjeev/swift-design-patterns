
class Document {
	
}

/// Incorrect Approach: Interfaces should be segregated, instead of putting them all in one single protocol.
protocol Machine {
	func print(document: Document)
	func scan(document: Document)
	func fax(document: Document)
}

class MultiFunctionMachine: Machine {
	func print(document: Document) {
		debugPrint("Printing the document...")
	}
	
	func scan(document: Document) {
		debugPrint("Scanning the document...")
	}
	
	func fax(document: Document) {
		debugPrint("Faxing the document...")
	}
}

class OldPrinter: Machine {
	func print(document: Document) {
		debugPrint("Printing the document...")
	}
	
	/// Drawback: forced to implement the functions which I don't need in a printer
	func scan(document: Document) {
		
	}
	
	func fax(document: Document) {
		
	}
}

/// Correct Approach: Break the Interfaces
protocol Printer {
	func print(document: Document)
}

protocol Scanner {
	func scan(document: Document)
}

protocol Fax {
	func fax(document: Document)
}

/// Only implement those behaviours, which are required.
class PhotocopyMachine: Printer, Scanner {
	func print(document: Document) {
		debugPrint("Printing the document...")
	}
	
	func scan(document: Document) {
		debugPrint("Scanning the document...")
	}
}
