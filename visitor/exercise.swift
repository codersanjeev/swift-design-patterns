protocol ExpressionVisitor {
	func accept(_ expression: Value)
	func accept(_ expression: AdditionExpression)
	func accept(_ expression: MultiplicationExpression)
}

protocol Expression {
	func visit(_ ev: ExpressionVisitor)
}

class Value: Expression {
	let value: Int
	init(_ value: Int) {
		self.value = value
	}
	
	func visit(_ acceptor: ExpressionVisitor) {
		acceptor.accept(self)
	}
}

class AdditionExpression: Expression {
	let lhs, rhs: Expression
	init(_ lhs: Expression, _ rhs: Expression) {
		self.lhs = lhs
		self.rhs = rhs
	}
	
	func visit(_ acceptor: ExpressionVisitor) {
		acceptor.accept(self)
	}
}

class MultiplicationExpression: Expression {
	let lhs, rhs: Expression
	init(_ lhs: Expression, _ rhs: Expression) {
		self.lhs = lhs
		self.rhs = rhs
	}
	func visit(_ acceptor: ExpressionVisitor) {
		acceptor.accept(self)
	}
}

class ExpressionPrinter: ExpressionVisitor, CustomStringConvertible {
	private var buffer = ""
	
	func accept(_ expression: Value) {
		buffer += String(expression.value)
	}
	
	func accept(_ expression: AdditionExpression) {
		buffer.append("(")
		expression.lhs.visit(self)
		buffer.append("+")
		expression.rhs.visit(self)
		buffer.append(")")
	}
	
	func accept(_ expression: MultiplicationExpression) {
		expression.lhs.visit(self)
		buffer.append("*")
		expression.rhs.visit(self)
	}
	
	var description: String {
		return buffer
	}
}
