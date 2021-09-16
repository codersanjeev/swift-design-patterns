class Point {
	var x = 0
	var y = 0
	
	init() {}
	
	init(x: Int, y: Int) {
		self.x = x
		self.y = y
	}
	
	func deepCopy() -> Point {
		let point = Point(x: self.x, y: self.y)
		return point
	}
}

class Line {
	var start = Point()
	var end = Point()
	
	init(start: Point, end: Point) {
		self.start = start
		self.end = end
	}
	
	func deepCopy() -> Line {
		let line = Line(start: self.start.deepCopy(), end: self.end.deepCopy())
		return line
	}
}
