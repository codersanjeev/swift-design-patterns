//
//  Factory.swift
//  swift-design-patterns
//
//  Created by sanjeev on 25/07/21.
//

import Foundation

// MARK:- Why use Factory Pattern?
class Point: CustomStringConvertible {
	var x, y: Double
	
	init(x: Double, y: Double) {
		self.x = x
		self.y = y
	}
	
	init(rho: Double, theta: Double) {
		self.x = rho * cos(theta)
		self.y = rho * sin(theta)
	}
	
	// Add more information in function name, something like this.
	static func createCartesian(x: Double, y: Double) -> Point {
		return Point(x: x, y: y)
	}
	
	static func createPolar(rho: Double, theta: Double) -> Point {
		return Point(rho: rho, theta: theta)
	}
	
	var description: String {
		return "(\(x), \(y))"
	}
}

// Doesn't provide any details about what type of point is
// being initialised?
let point = Point(x: 0, y: 1)
// Somewhat good
let anotherPoint = Point.createPolar(rho: 1, theta: 2)
print(point)
print(anotherPoint)


// MARK:- Better Approach
// initialisers can be made private and PointFactory can be made inner class of Point class.
// expose a singleton (static let) instance of Factory from Point class.
class PointFactory {
	func createCartesian(x: Double, y: Double) -> Point {
		return Point(x: x, y: y)
	}
	
	func createPolar(rho: Double, theta: Double) -> Point {
		return Point(rho: rho, theta: theta)
	}
}

let pointFactory = PointFactory()
let someAnotherPoint = pointFactory.createPolar(rho: 3, theta: 4)
print(someAnotherPoint)

