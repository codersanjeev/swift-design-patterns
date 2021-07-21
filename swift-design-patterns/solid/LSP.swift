//
//  LSP.swift
//  swift-design-patterns
//
//  Created by sanjeev on 18/07/21.
//

import Foundation

class Rectangle : CustomStringConvertible {
	
	internal var _height: Int = 0
	internal var _width: Int = 0
	
	var height: Int {
		get {
			return _height
		}
		set(value) {
			_height = value
		}
	}
	
	var width: Int {
		get {
			return _width
		}
		set(value) {
			_width = value
		}
	}
	
	init(_ height: Int, _ width: Int) {
		self.height = height
		self.width = width
	}
	
	public var description: String {
		return "Width: \(width), Height: \(height)"
	}
	
}

// MARK:- Wrong Approach
// A Square is also a rectangle, so extending Rectangle
class Square : Rectangle {
	override var height: Int {
		get {
			return _height
		}
		set(value) {
			_height = value
			_width = value
		}
	}
	
	override var width: Int {
		get {
			return _width
		}
		set(value) {
			_height = value
			_width = value
		}
	}
}

private func calculateArea(_ shape: Rectangle) -> Int {
	return shape.height * shape.width
}

//let rectangle = Rectangle(10, 5)
//print("Rectangle has Area = \(calculateArea(rectangle)), Expected = 50")
//
//let square: Rectangle = Square(0, 0)
//square.width = 4
//print("Square has Area = \(calculateArea(square)), Expected = 16")
