import Foundation

class Point: CustomStringConvertible, Hashable, Equatable {
	var x, y: Int
	
	init(_ x: Int, _ y: Int) {
		self.x = x
		self.y = y
	}
	
	var hashValue: Int {
		return (x * 341) ^ y
	}
	
	static func == (lhs: Point, rhs: Point) -> Bool {
		return lhs.x == rhs.x && lhs.y == rhs.y
	}
	
	var description: String {
		return "(\(x), \(y))"
	}
}

class Line {
	var start, end: Point
	
	init(_ start: Point, _ end: Point) {
		self.start = start
		self.end = end
	}
}

class VectorObject: Sequence {
	var lines = [Line]()
	
	func makeIterator() -> some IteratorProtocol {
		return IndexingIterator(_elements: lines)
	}
}

class VectorRectangle: VectorObject {
	init(_ x: Int, _ y: Int, _ height: Int, _ width: Int) {
		super.init()
		lines.append(Line(Point(x, y), Point(x + width, y)))
		lines.append(Line(Point(x + width, y), Point(x + width, y + height)))
		lines.append(Line(Point(x, y), Point(x, y + height)))
		lines.append(Line(Point(x, y + height), Point(x + width, y + height)))
	}
}

class LineToPointAdapter: Sequence {
	private static var count = 0
	var points = [Point]()
	
	init(_ line: Line) {
		type(of: self).count += 1
		// Algorithm to populate points array from given line
	}
	
	func makeIterator() -> some IteratorProtocol {
		return IndexingIterator(_elements: points)
	}
}

func drawPoint(_ point: Point) {
	print(".", terminator: "")
}

let objects = [VectorRectangle(1, 1, 10, 10), VectorRectangle(3, 3, 6, 6)]

for object in objects {
	for line in object.lines {
		let adapter = LineToPointAdapter(line)
		adapter.forEach { point in
			guard let point = point as? Point else { return }
			drawPoint(point)
		}
	}
}
