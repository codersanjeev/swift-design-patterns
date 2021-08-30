
class Rectangle: CustomStringConvertible {
	var _width = 0
	var _height = 0
	
	var width: Int {
		get { return _width }
		set(value) { _width = value }
	}
	
	var height: Int {
		get { return _height }
		set(value) { _height = value }
	}
	
	var area: Int {
		return height * width
	}
	
	init() {}
	
	init(_ width: Int, _ height: Int) {
		_width = width
		_height = height
	}
	
	var description: String {
		return "Width: \(width), Height: \(height)"
	}
}

/// Incorrect Approach: Breaking `Liskov Substitution Principle`
//  - Modified the behaviour of base class `Rectangle` in child class `Square`
//  - Child class is not substitutable in setAndMeasure function
class Square: Rectangle {
	override var width: Int {
		get { return _width }
		set(value) {
			_width = value
			_height = value
		}
	}
	
	override var height: Int {
		get { return _height }
		set(value) {
			_width = value
			_height = value
		}
	}
}

/// Correct Approach
protocol Shape {
	func calculateArea() -> Int
}

class CorrectRectangle: Shape {
	private let width: Int
	private let height: Int
	
	init(_ width: Int, height: Int) {
		self.width = width
		self.height = height
	}
	
	func calculateArea() -> Int {
		return height * width
	}
}

class CorrectSquare: Shape {
	private let side: Int
	
	init(_ side: Int) {
		self.side = side
	}
	
	func calculateArea() -> Int {
		return side * side
	}
}

// MARK:- Usage
func main() {
	let rectangle = Rectangle()
	setAndMeasure(rectangle)
	let square = Square()
	setAndMeasure(square)
}

func setAndMeasure(_ rectangle: Rectangle) {
	rectangle.width =  5
	rectangle.height = 10
	print("Expected area: 50, Actual area: \(rectangle.area)")
}

main()
