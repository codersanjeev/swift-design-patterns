import Foundation

protocol DiscriminantStrategy {
	func calculateDiscriminant(_ a: Double, _ b: Double, _ c: Double) -> Double
}

class OrdinaryDiscriminantStrategy: DiscriminantStrategy {
	func calculateDiscriminant(_ a: Double, _ b: Double, _ c: Double) -> Double {
		return (b * b) - (4 * a * c)
	}
}

class RealDiscriminantStrategy : DiscriminantStrategy {
	func calculateDiscriminant(_ a: Double, _ b: Double, _ c: Double) -> Double {
		return Double.nan
	}
}

class QuadraticEquationSolver {
	private let strategy: DiscriminantStrategy
	
	init(_ strategy: DiscriminantStrategy) {
		self.strategy = strategy
	}
	
	func solve(_ a: Double, _ b: Double, _ c: Double) -> (Double, Double) {
		let d = strategy.calculateDiscriminant(a, b, c)
		if d.isNaN {
			return (Double.nan, Double.nan)
		} else {
			let x = -1 * b + sqrt(d)
			let y = -1 * b - sqrt(d)
			return (x / 2 * a, y / 2 * a)
		}
	}
}
