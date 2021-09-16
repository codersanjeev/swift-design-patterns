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

class PointFactory {
	func createCartesian(x: Double, y: Double) -> Point {
		return Point(x: x, y: y)
	}
	
	func createPolar(rho: Double, theta: Double) -> Point {
		return Point(rho: rho, theta: theta)
	}
}

let pointFactory = PointFactory()
let point = pointFactory.createPolar(rho: 1, theta: 2)
debugPrint(point)
