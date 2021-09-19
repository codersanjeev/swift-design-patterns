import Foundation
import XCTest

class Token {
	var value = 0
	init(_ value: Int) {
		self.value = value
	}
	static func ==(_ lhs: Token, _ rhs: Token) -> Bool {
		return lhs.value == rhs.value
	}
}

class Memento {
	var tokens = [Token]()
}

class TokenMachine {
	var tokens = [Token]()
	
	func addToken(_ value: Int) -> Memento {
		tokens.append(Token(value))
		let memento = Memento()
		memento.tokens = tokens
		return memento
	}
	
	func addToken(_ token: Token) -> Memento {
		tokens.append(token)
		let memento = Memento()
		memento.tokens = tokens
		return memento
	}
	
	func revert(to memento: Memento) {
		self.tokens = memento.tokens
	}
}
