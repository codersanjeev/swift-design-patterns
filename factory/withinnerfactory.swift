import Foundation

class Point: CustomStringConvertible {
	private var x, y: Double
	
	private init(x: Double, y: Double) {
		self.x = x
		self.y = y
	}
	
	private init(rho: Double, theta: Double) {
		self.x = rho * cos(theta)
		self.y = rho * sin(theta)
	}

	static let factory = PointFactory.instance
	
	class PointFactory {
		
		private init() {}
		static let instance = PointFactory()
		
		func createCartesian(x: Double, y: Double) -> Point {
			return Point(x: x, y: y)
		}
		
		func createPolar(rho: Double, theta: Double) -> Point {
			return Point(rho: rho, theta: theta)
		}
	}
	
	var description: String {
		return "x = \(x), y = \(y)"
	}
}

let pointFactory = Point.factory
let point = pointFactory.createPolar(rho: 1, theta: 2)
debugPrint(point)
