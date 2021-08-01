//
//  Adapter.swift
//  swift-design-patterns
//
//  Created by sanjeev on 01/08/21.
//

import Foundation

class Point {
	
	var x, y: Int
	
	init(_ x: Int, _ y: Int) {
		self.x = x
		self.y = y
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
	
	init(_ x: Int, _ y: Int, _ width: Int, _ height: Int) {
		super.init()
		lines.append(Line(Point(x, y), Point(x + width, y)))
		lines.append(Line(Point(x + width, y), Point(x + width, y + height)))
		lines.append(Line(Point(x, y), Point(x, y + height)))
		lines.append(Line(Point(x, y + height), Point(x + width, y + height)))
	}
	
}

func drawPoint(_ point: Point) {
	print(point)
}

// Requirement: we want to draw an object and we have draw API

let vectorObject = [
	VectorRectangle(1, 1, 10, 10),
	VectorRectangle(3, 3, 6, 6)
]

class LineToPointAdapter: Sequence {
	
	private static var count = 0
	var points = [Point]()
	
	init(_ line: Line) {
		// Algorithm to convert line to point
		// and populate points array
	}
	
	func makeIterator() -> some IteratorProtocol {
		return IndexingIterator(_elements: points)
	}
	
}



for vector in vectorObject {
	for line in vector {
		let adapter = LineToPointAdapter(point)
		adapter.forEach {
			drawPoint($0)
		}
	}
}
