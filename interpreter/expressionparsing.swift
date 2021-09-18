import Foundation

extension String {
	subscript(offset: Int) -> Character {
		return self[index(startIndex, offsetBy: offset)]
	}
	
	var isNumber: Bool {
		return !self.isEmpty && self.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
	}
}

struct Token: CustomStringConvertible {
	enum TokenType {
		case integer
		case plus
		case minus
		case lparen
		case rparen
	}
	
	var tokenType: TokenType
	var text: String
	
	init(_ tokenType: TokenType, _ text: String) {
		self.tokenType = tokenType
		self.text = text
	}
	
	var description: String {
		return "`\(text)`"
	}
}

func lexer(_ input: String) -> [Token] {
	var result = [Token]()
	var index = 0
	while index < input.count {
		switch input[index] {
			case "+":
				result.append(Token(.plus, "+"))
			case "-":
				result.append(Token(.minus, "-"))
			case "(":
				result.append(Token(.lparen, "("))
			case ")":
				result.append(Token(.rparen, ")"))
			default:
				var curr = String(input[index])
				for j in (index + 1) ..< input.count {
					if String(input[j]).isNumber {
						curr.append(input[j])
						index += 1
					} else {
						result.append(Token(.integer, curr))
						break
					}
				}
		}
		index += 1
	}
	return result
}

protocol Element {
	var value: Int { get }
}

class Integer: Element {
	var value: Int
	
	init(_ value: Int) {
		self.value = value
	}
}

class BinaryOperation: Element {
	enum OperationType {
		case addition
		case subtraction
	}
	
	var operationType = OperationType.addition
	var left: Element = Integer(0)
	var right: Element = Integer(0)
	
	init() {}
	init(_ left: Element, _ right: Element, _ operationType: OperationType) {
		self.operationType = operationType
		self.left = left
		self.right = right
	}
	
	var value: Int {
		switch operationType {
			case .addition: return left.value + right.value
			case .subtraction: return left.value - right.value
		}
	}
}

func parse(_ tokens: [Token]) -> Element {
	let result = BinaryOperation()
	var haveLHS = false
	var index = 0
	while index < tokens.count {
		let token = tokens[index]
		switch token.tokenType {
			case .integer:
				let integer = Integer(Int(token.text)!)
				if !haveLHS {
					result.left = integer
					haveLHS = true
				} else {
					result.right = integer
				}
			case .plus:
				result.operationType = .addition
			case .minus:
				result.operationType = .subtraction
			case .lparen:
				var anotherIndex = index
				while anotherIndex < tokens.count {
					if tokens[anotherIndex].tokenType == .rparen {
						break
					}
					anotherIndex += 1
				}
				let subexpression = Array(tokens[(index + 1) ..< anotherIndex])
				let element = parse(subexpression)
				if !haveLHS {
					result.left = element
					haveLHS = true
				} else {
					result.right = element
				}
				index = anotherIndex
			default: break
		}
		index += 1
	}
	return result
}

let s = "(13+4)-(12-1)"
let tokens = lexer(s)
print(tokens)
let result = parse(tokens)
print(result.value)
