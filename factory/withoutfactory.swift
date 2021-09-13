import Foundation

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
	
	var description: String {
		return "x = \(x), y = \(y)"
	}
}

// Constructor call is not informative
let point = Point(rho: 1, theta: 2)
debugPrint(point)
