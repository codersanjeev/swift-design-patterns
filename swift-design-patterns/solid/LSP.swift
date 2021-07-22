//
//  LSP.swift
//  swift-design-patterns
//
//  Created by sanjeev on 18/07/21.
//

import Foundation

// LSP
class Rectangle {
	var height: Int
	var width: Int
	
	init(height: Int, width: Int) {
		self.height = height
		self.width = width
	}
	
	func area() -> Int {
		return height * width
	}
}

// MARK:- Wrong Approach
class Square: Rectangle {
	override var height: Int {
		didSet {
			super.width = height
		}
	}
	
	override var width: Int {
		didSet {
			super.height = width
		}
	}
}

let square = Square(height: 10, width: 10)
print(square.area())
let rectangle: Rectangle = square
rectangle.height = 20
print(rectangle.width)
rectangle.width = 10
print(rectangle.area()) // prints 100

// MARK:- Correct Approach

