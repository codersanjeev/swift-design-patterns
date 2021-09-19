import Foundation

protocol ExpressionVisitor {
	func visit(_ expression: DoubleExpression)
	func visit(_ expression: AdditionExpression)
}

protocol Expression {
	func accept(_ visitor: ExpressionVisitor)
}

class DoubleExpression: Expression {
	var value: Double
	
	init(_ value: Double) {
		self.value = value
	}
	
	func accept(_ visitor: ExpressionVisitor) {
		visitor.visit(self)
	}
}

class AdditionExpression: Expression {
	var left, right: Expression
	
	init(_ left: Expression, _ right: Expression) {
		self.left = left
		self.right = right
	}
	
	func accept(_ visitor: ExpressionVisitor) {
		visitor.visit(self)
	}
}

class ExpressionPrinter: ExpressionVisitor, CustomStringConvertible {
	private var buffer = ""
	
	func visit(_ expression: DoubleExpression) {
		buffer.append(String(expression.value))
	}
	
	func visit(_ expression: AdditionExpression) {
		buffer.append("(")
		expression.left.accept(self)
		buffer.append("+")
		expression.right.accept(self)
		buffer.append(")")
	}
	
	var description: String {
		return buffer
	}
}

let expression = AdditionExpression(
	DoubleExpression(1),
	AdditionExpression(DoubleExpression(2), DoubleExpression(3))
)

let expressionPrinter = ExpressionPrinter()
expressionPrinter.visit(expression)
print(expressionPrinter)
