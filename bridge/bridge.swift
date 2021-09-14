import Foundation

protocol Renderer {
	func renderCircle(_ radius: Float)
}

class VectorRenderer: Renderer {
	func renderCircle(_ radius: Float) {
		debugPrint("Drawing a Circle of radius = \(radius)")
	}
}

class RasterRenderer: Renderer {
	func renderCircle(_ radius: Float) {
		debugPrint("Drawing pixels for Circle of radius = \(radius)")
	}
}

protocol Shape {
	func draw()
	func resize(_ scale: Float)
}

class Circle: Shape {
	var radius: Float
	var renderer: Renderer
	
	init(_ radius: Float, _ renderer: Renderer) {
		self.radius = radius
		self.renderer = renderer
	}
	
	func draw() {
		renderer.renderCircle(radius)
	}
	
	func resize(_ scale: Float) {
		radius *= scale
	}
}

let raster = RasterRenderer()
let vector = VectorRenderer()
let circle = Circle(5, raster)
let anotherCircle = Circle(10, vector)
circle.draw()
anotherCircle.draw()